module 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        credit: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>,
        ion: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>,
        shard: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>,
        credit_out: u64,
        ion_out: u64,
        shard_out: u64,
        cards_out: u64,
        strongroom: 0x2::object::ID,
        strongroom_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Withdraw has copy, drop {
        player: 0x1::string::String,
        kind: u8,
        amount: u64,
        code: 0x1::string::String,
        to: address,
    }

    struct Deposit has copy, drop {
        player: 0x1::string::String,
        kind: u8,
        amount: u64,
        code: 0x1::string::String,
        sender: address,
    }

    public fun admin(arg0: &Vault) : address {
        arg0.admin
    }

    public fun cards_out(arg0: &Vault) : u64 {
        arg0.cards_out
    }

    public fun create(arg0: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>, arg1: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>, arg2: 0x2::coin::TreasuryCap<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        let v2 = v0;
        let v3 = Vault{
            id             : 0x2::object::new(arg3),
            version        : 1,
            admin          : 0x2::tx_context::sender(arg3),
            credit         : arg0,
            ion            : arg1,
            shard          : arg2,
            credit_out     : 0,
            ion_out        : 0,
            shard_out      : 0,
            cards_out      : 0,
            strongroom     : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            strongroom_cap : v1,
        };
        0x2::transfer::share_object<Vault>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
    }

    public fun credit_out(arg0: &Vault) : u64 {
        arg0.credit_out
    }

    public fun deposit_card(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card, arg3: &0x2::tx_context::TxContext) {
        require_version(arg0);
        require_player(&arg1);
        arg0.cards_out = arg0.cards_out - 1;
        let v0 = Deposit{
            player : arg1,
            kind   : 2,
            amount : 1,
            code   : 0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::burn(arg2),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v0);
    }

    public fun deposit_card_from_kiosk(arg0: &mut Vault, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::transfer_policy::TransferPolicy<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        require_version(arg0);
        require_player(&arg5);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.strongroom, 13836466190375452681);
        let (v0, v1) = 0x2::kiosk::purchase<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(arg2, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let v2 = v1;
        let v3 = v0;
        arg0.cards_out = arg0.cards_out - 1;
        0x2::kiosk::lock<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(arg1, &arg0.strongroom_cap, arg4, v3);
        if (0x2::transfer_policy::has_rule<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(&mut v2, arg1);
        };
        if (0x2::transfer_policy::has_rule<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(arg4, &mut v2, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(arg4, v2);
        let v7 = Deposit{
            player : arg5,
            kind   : 2,
            amount : 1,
            code   : *0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::code(&v3),
            sender : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<Deposit>(v7);
    }

    public fun deposit_credit(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>, arg3: &0x2::tx_context::TxContext) {
        require_version(arg0);
        require_player(&arg1);
        let v0 = 0x2::coin::value<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>(&arg2);
        assert!(v0 > 0, 13835903081507979269);
        arg0.credit_out = arg0.credit_out - v0;
        0x2::coin::burn<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>(&mut arg0.credit, arg2);
        let v1 = Deposit{
            player : arg1,
            kind   : 0,
            amount : v0,
            code   : 0x1::string::utf8(b""),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun deposit_ion(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>, arg3: &0x2::tx_context::TxContext) {
        require_version(arg0);
        require_player(&arg1);
        let v0 = 0x2::coin::value<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>(&arg2);
        assert!(v0 > 0, 13835903124457652229);
        arg0.ion_out = arg0.ion_out - v0;
        0x2::coin::burn<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>(&mut arg0.ion, arg2);
        let v1 = Deposit{
            player : arg1,
            kind   : 1,
            amount : v0,
            code   : 0x1::string::utf8(b""),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun deposit_shard(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>, arg3: &0x2::tx_context::TxContext) {
        require_version(arg0);
        require_player(&arg1);
        let v0 = 0x2::coin::value<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>(&arg2);
        assert!(v0 > 0, 13835903167407325189);
        arg0.shard_out = arg0.shard_out - v0;
        0x2::coin::burn<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>(&mut arg0.shard, arg2);
        let v1 = Deposit{
            player : arg1,
            kind   : 3,
            amount : v0,
            code   : 0x1::string::utf8(b""),
            sender : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun ion_out(arg0: &Vault) : u64 {
        arg0.ion_out
    }

    fun require_admin(arg0: &Vault, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13835340496626515969);
    }

    fun require_player(arg0: &0x1::string::String) {
        let v0 = 0x1::string::length(arg0);
        assert!(v0 > 0 && v0 <= 32, 13835621993078194179);
    }

    fun require_version(arg0: &Vault) {
        assert!(arg0.version == 1, 13836184904377171975);
    }

    public fun set_admin(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        require_version(arg0);
        require_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun shard_out(arg0: &Vault) : u64 {
        arg0.shard_out
    }

    public fun strongroom(arg0: &Vault) : 0x2::object::ID {
        arg0.strongroom
    }

    public fun version(arg0: &Vault) : u64 {
        arg0.version
    }

    public fun withdraw_card(arg0: &mut Vault, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        require_version(arg0);
        require_admin(arg0, arg9);
        require_player(&arg1);
        arg0.cards_out = arg0.cards_out + 1;
        0x2::transfer::public_transfer<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::Card>(0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::card::mint(arg2, arg3, arg4, arg5, arg6, arg7, arg9), arg8);
        let v0 = Withdraw{
            player : arg1,
            kind   : 2,
            amount : 1,
            code   : arg2,
            to     : arg8,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    public fun withdraw_credit(arg0: &mut Vault, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        require_version(arg0);
        require_admin(arg0, arg4);
        require_player(&arg1);
        assert!(arg2 > 0, 13835902914004254725);
        arg0.credit_out = arg0.credit_out + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>>(0x2::coin::mint<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::credit::CREDIT>(&mut arg0.credit, arg2, arg4), arg3);
        let v0 = Withdraw{
            player : arg1,
            kind   : 0,
            amount : arg2,
            code   : 0x1::string::utf8(b""),
            to     : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    public fun withdraw_ion(arg0: &mut Vault, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        require_version(arg0);
        require_admin(arg0, arg4);
        require_player(&arg1);
        assert!(arg2 > 0, 13835902956953927685);
        arg0.ion_out = arg0.ion_out + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>>(0x2::coin::mint<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::ion::ION>(&mut arg0.ion, arg2, arg4), arg3);
        let v0 = Withdraw{
            player : arg1,
            kind   : 1,
            amount : arg2,
            code   : 0x1::string::utf8(b""),
            to     : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    public fun withdraw_shard(arg0: &mut Vault, arg1: 0x1::string::String, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        require_version(arg0);
        require_admin(arg0, arg4);
        require_player(&arg1);
        assert!(arg2 > 0, 13835902999903600645);
        arg0.shard_out = arg0.shard_out + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>>(0x2::coin::mint<0xc0ecc184efcc2605e55b24afe103dc9d88c7e4cdc918061fcbe42d4f81fe32c3::shard::SHARD>(&mut arg0.shard, arg2, arg4), arg3);
        let v0 = Withdraw{
            player : arg1,
            kind   : 3,
            amount : arg2,
            code   : 0x1::string::utf8(b""),
            to     : arg3,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v7
}

