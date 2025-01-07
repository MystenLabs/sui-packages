module 0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::bank {
    struct BANK has drop {
        dummy_field: bool,
    }

    struct Bank has store, key {
        id: 0x2::object::UID,
        SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        HUSKI: 0x2::balance::Balance<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>,
    }

    struct AddTokenIdoWhitelistEvent has copy, drop {
        ido_id: 0x2::object::ID,
    }

    struct BuyTokenIdoTokenEvent has copy, drop {
        ido_id: 0x2::object::ID,
        in_amount: u64,
        out_amount: u64,
    }

    struct TokenIdo has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        price: u64,
        is_public: bool,
        whitelists: 0x2::table::Table<address, u8>,
    }

    struct AddTokenAirdropWhitelistEvent has copy, drop {
        airdrop_id: 0x2::object::ID,
    }

    struct Airdrop has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        amount_listed: u64,
        amount_unlisted: u64,
        whitelists: 0x2::table::Table<address, u8>,
        blacklists: 0x2::table::Table<address, u8>,
    }

    public entry fun add_address_to_airdrop(arg0: &mut Airdrop, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, u8>(&arg0.whitelists, v0) == false) {
            0x2::table::add<address, u8>(&mut arg0.whitelists, v0, 1);
        };
        let v1 = AddTokenAirdropWhitelistEvent{airdrop_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<AddTokenAirdropWhitelistEvent>(v1);
    }

    public entry fun add_address_to_ido(arg0: &mut TokenIdo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, u8>(&arg0.whitelists, v0) == false) {
            0x2::table::add<address, u8>(&mut arg0.whitelists, v0, 1);
        };
        let v1 = AddTokenIdoWhitelistEvent{ido_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<AddTokenIdoWhitelistEvent>(v1);
    }

    public entry fun add_huski_to_bank(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>) {
        assert!(0x2::coin::value<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&arg1) > 0, 0);
        0x2::balance::join<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&mut arg0.HUSKI, 0x2::coin::into_balance<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(arg1));
    }

    public entry fun add_sui_to_bank(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) > 0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.SUI, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun buy_token_from_ido(arg0: &TokenIdo, arg1: &mut Bank, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.SUI, 0x2::coin::into_balance<0x2::sui::SUI>(0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::utils::merge_coins_to_amount_and_transfer_back_rest<0x2::sui::SUI>(arg2, arg3, arg4)));
        let v0 = arg3 / arg0.price;
        assert!(0x2::balance::value<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&arg1.HUSKI) >= v0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>>(0x2::coin::from_balance<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(0x2::balance::split<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&mut arg1.HUSKI, v0), arg4), 0x2::tx_context::sender(arg4));
        let v1 = BuyTokenIdoTokenEvent{
            ido_id     : 0x2::object::uid_to_inner(&arg0.id),
            in_amount  : arg3,
            out_amount : v0,
        };
        0x2::event::emit<BuyTokenIdoTokenEvent>(v1);
    }

    public entry fun buy_token_from_ido_listed(arg0: &mut TokenIdo, arg1: &mut Bank, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(token_ido_is_public_or_has_whitelist_address(arg0, 0x2::tx_context::sender(arg4)) == true, 144005);
        buy_token_from_ido(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy_token_from_ido_unlisted(arg0: &mut TokenIdo, arg1: &mut Bank, arg2: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        buy_token_from_ido(arg0, arg1, arg2, arg3, arg4);
    }

    fun claim_airdrop(arg0: &mut Bank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>>(0x2::coin::from_balance<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(0x2::balance::split<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&mut arg0.HUSKI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_airdrop_listed(arg0: &mut Airdrop, arg1: &mut Bank, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(token_airdrop_is_public_or_has_whitelist_address(arg0, v0) == true, 144005);
        claim_airdrop(arg1, arg0.amount_listed, arg2);
        0x2::table::remove<address, u8>(&mut arg0.whitelists, v0);
    }

    public entry fun claim_airdrop_unlisted(arg0: &mut Airdrop, arg1: &mut Bank, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(token_airdrop_is_public_or_has_blacklist_address(arg0, v0) == false, 144005);
        claim_airdrop(arg1, arg0.amount_unlisted, arg2);
        0x2::table::add<address, u8>(&mut arg0.blacklists, v0, 1);
    }

    public entry fun create_airdrop(arg0: &0x2::package::Publisher, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        let v0 = Airdrop{
            id              : 0x2::object::new(arg4),
            name            : arg1,
            amount_listed   : arg2,
            amount_unlisted : arg3,
            whitelists      : 0x2::table::new<address, u8>(arg4),
            blacklists      : 0x2::table::new<address, u8>(arg4),
        };
        0x2::transfer::share_object<Airdrop>(v0);
    }

    fun create_bank(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id    : 0x2::object::new(arg0),
            SUI   : 0x2::balance::zero<0x2::sui::SUI>(),
            HUSKI : 0x2::balance::zero<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(),
        };
        0x2::transfer::public_share_object<Bank>(v0);
    }

    public entry fun create_ido(arg0: &0x2::package::Publisher, arg1: vector<u8>, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        assert!(arg2 > 0, 14400);
        let v0 = TokenIdo{
            id         : 0x2::object::new(arg4),
            name       : arg1,
            price      : arg2,
            is_public  : arg3,
            whitelists : 0x2::table::new<address, u8>(arg4),
        };
        0x2::transfer::share_object<TokenIdo>(v0);
    }

    fun init(arg0: BANK, arg1: &mut 0x2::tx_context::TxContext) {
        create_bank(arg1);
        0x2::package::claim_and_keep<BANK>(arg0, arg1);
    }

    public entry fun remove_huski_from_bank(arg0: &0x2::package::Publisher, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        assert!(arg2 <= 0x2::balance::value<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&arg1.HUSKI), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>>(0x2::coin::take<0xda1644f58a955833a15abae24f8cc65b5bd8152ce013fde8be0a6a3dcf51fe36::token::TOKEN>(&mut arg1.HUSKI, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun remove_sui_from_bank(arg0: &0x2::package::Publisher, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.SUI), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.SUI, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun set_ido_price(arg0: &0x2::package::Publisher, arg1: &mut TokenIdo, arg2: u64) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        arg1.price = arg2;
    }

    public entry fun set_ido_public(arg0: &0x2::package::Publisher, arg1: &mut TokenIdo, arg2: bool) {
        assert!(0x2::package::from_package<BANK>(arg0), 0);
        arg1.is_public = arg2;
    }

    fun token_airdrop_is_public_or_has_blacklist_address(arg0: &Airdrop, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.blacklists, arg1)
    }

    fun token_airdrop_is_public_or_has_whitelist_address(arg0: &Airdrop, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.whitelists, arg1)
    }

    fun token_ido_is_public_or_has_whitelist_address(arg0: &TokenIdo, arg1: address) : bool {
        arg0.is_public || 0x2::table::contains<address, u8>(&arg0.whitelists, arg1)
    }

    // decompiled from Move bytecode v6
}

