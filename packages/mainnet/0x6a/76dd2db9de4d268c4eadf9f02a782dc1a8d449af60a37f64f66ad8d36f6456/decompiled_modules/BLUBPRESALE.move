module 0x8bd38a257ad85ba8bb0e491d450fa25b9afdeb881e435b179e50bc92e6038568::BLUBPRESALE {
    struct BLUBPRESALE has drop {
        dummy_field: bool,
    }

    struct BlubPreSaleNFT has store, key {
        id: 0x2::object::UID,
        balance: u64,
    }

    struct ManageBlubPreSale has store, key {
        id: 0x2::object::UID,
        treasure: address,
    }

    struct BlubPreSale has store, key {
        id: 0x2::object::UID,
        open: bool,
        rate: u64,
        coin_sui: 0x2::coin::Coin<0x2::sui::SUI>,
        blub_available_balance: u64,
        raise_sui_amount: u64,
        blub_airdrop_amount: u64,
        transfers: u64,
        blub_minted: u64,
        members: 0x2::table::Table<address, u64>,
    }

    struct BlubBuyback has store, key {
        id: 0x2::object::UID,
        open: bool,
        transfers: u64,
        blub_burned: u64,
        sui_minted: u64,
    }

    public entry fun add_balance(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: u64) {
        arg0.blub_available_balance = arg0.blub_available_balance + arg2;
    }

    public entry fun airdrop(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        if (!arg0.open) {
            abort 777
        };
        let v0 = 0;
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(0x1::vector::length<u64>(&arg3) == v1, 111);
        while (v0 < v1) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v0) / 10000000 * arg0.rate;
            if (v2 > arg0.blub_available_balance) {
                abort 888
            };
            update_sale(arg0, v2, 0);
            0x2::transfer::public_transfer<BlubPreSaleNFT>(new_blub(v2, arg4), *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun balance(arg0: &BlubPreSaleNFT) : u64 {
        arg0.balance
    }

    public fun burn_blub(arg0: BlubPreSaleNFT) : u64 {
        let BlubPreSaleNFT {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public entry fun buy(arg0: &mut BlubPreSale, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!arg0.open) {
            abort 777
        };
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) / 10000000 * arg0.rate;
        if (v0 > arg0.blub_available_balance) {
            abort 888
        };
        update_sale(arg0, v0, 0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin_sui, arg1);
        0x2::transfer::public_transfer<BlubPreSaleNFT>(new_blub(v0, arg3), arg2);
    }

    public fun buyback(arg0: &mut BlubBuyback, arg1: &mut BlubPreSale, arg2: BlubPreSaleNFT, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.open == false) {
            abort 111
        };
        let v0 = burn_blub(arg2);
        let v1 = 841380000;
        if (v0 == 4206900) {
            v1 = 420690000 / 50;
        };
        let v2 = v0 * 10000 / v1 * 1000;
        arg0.transfers = arg0.transfers + 1;
        arg0.blub_burned = arg0.blub_burned + v0;
        arg0.sui_minted = arg0.sui_minted + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin_sui, v2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun buyback_nft(arg0: &mut BlubBuyback, arg1: &mut BlubPreSale, arg2: BlubPreSaleNFT, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.open == false) {
            abort 111
        };
        let v0 = burn_blub(arg2);
        let v1 = 420690000;
        if (v0 == 4206900) {
            v1 = 420690000 / 50;
        };
        let v2 = v0 * 10000 / v1 * 1000;
        arg0.transfers = arg0.transfers + 1;
        arg0.blub_burned = arg0.blub_burned + v0;
        arg0.sui_minted = arg0.sui_minted + v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.coin_sui, v2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun create_buyback(arg0: &ManageBlubPreSale, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlubBuyback{
            id          : 0x2::object::new(arg1),
            open        : true,
            transfers   : 0,
            blub_burned : 0,
            sui_minted  : 0,
        };
        0x2::transfer::share_object<BlubBuyback>(v0);
    }

    public entry fun deposit(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.coin_sui, arg2);
    }

    public entry fun get_free(arg0: &mut BlubPreSale, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (!arg0.open) {
            abort 777
        };
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::table::contains<address, u64>(&arg0.members, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.members, v0);
            if (*v2 >= v1 - 500) {
                abort 999
            };
            *v2 = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.members, v0, v1);
        };
        let v3 = arg0.blub_airdrop_amount;
        if (v3 > arg0.blub_available_balance) {
            abort 888
        };
        update_sale(arg0, v3, 0);
        0x2::transfer::public_transfer<BlubPreSaleNFT>(new_blub(v3, arg2), v0);
    }

    fun init(arg0: BLUBPRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlubPreSale{
            id                     : 0x2::object::new(arg1),
            open                   : true,
            rate                   : 420690000,
            coin_sui               : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            blub_available_balance : 21034500000000000,
            raise_sui_amount       : 0,
            blub_airdrop_amount    : 4206900 * 100,
            transfers              : 0,
            blub_minted            : 0,
            members                : 0x2::table::new<address, u64>(arg1),
        };
        let v1 = ManageBlubPreSale{
            id       : 0x2::object::new(arg1),
            treasure : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<ManageBlubPreSale>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<BlubPreSale>(v0);
        let v2 = 0x2::package::claim<BLUBPRESALE>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://blubsui.com/presale.png"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Blub - A Dirty Fish in the Waters of the Sui Ocean"));
        let v7 = 0x2::display::new_with_fields<BlubPreSaleNFT>(&v2, v3, v5, arg1);
        0x2::display::update_version<BlubPreSaleNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<BlubPreSaleNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
    }

    fun new_blub(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : BlubPreSaleNFT {
        BlubPreSaleNFT{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public entry fun update_blub_airdrop_amount(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: u64) {
        if (arg2 > 4206900 * 100 * 20) {
            abort 503
        };
        arg0.blub_airdrop_amount = arg2;
    }

    public entry fun update_buyback_open(arg0: &mut BlubBuyback, arg1: &ManageBlubPreSale, arg2: bool) {
        arg0.open = arg2;
    }

    public entry fun update_open(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: bool) {
        arg0.open = arg2;
    }

    public entry fun update_rate(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: u64) {
        arg0.rate = arg2;
    }

    fun update_sale(arg0: &mut BlubPreSale, arg1: u64, arg2: u64) {
        arg0.transfers = arg0.transfers + 1;
        arg0.blub_minted = arg0.blub_minted + arg1;
        arg0.blub_available_balance = arg0.blub_available_balance - arg1;
        arg0.raise_sui_amount = arg0.raise_sui_amount + arg2;
    }

    public entry fun update_treasure(arg0: &mut ManageBlubPreSale, arg1: address) {
        arg0.treasure = arg1;
    }

    public entry fun withdraw(arg0: &mut BlubPreSale, arg1: &ManageBlubPreSale, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0.coin_sui, 0x2::coin::value<0x2::sui::SUI>(&arg0.coin_sui), arg2), arg1.treasure);
    }

    // decompiled from Move bytecode v6
}

