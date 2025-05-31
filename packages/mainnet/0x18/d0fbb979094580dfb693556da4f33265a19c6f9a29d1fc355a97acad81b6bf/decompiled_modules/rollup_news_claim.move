module 0x18d0fbb979094580dfb693556da4f33265a19c6f9a29d1fc355a97acad81b6bf::rollup_news_claim {
    struct ClaimCreatedEvent has copy, drop {
        claim_id: 0x2::object::ID,
        recipient: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        data: 0x1::string::String,
    }

    struct MasterPower has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        wallets: 0x2::object_table::ObjectTable<address, Wallet>,
    }

    struct Wallet has store, key {
        id: 0x2::object::UID,
        address: address,
        minting_limit: u64,
        last_minting_period_ms: u64,
    }

    struct Claim has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        data: 0x1::string::String,
    }

    public entry fun create_claim(arg0: &0x2::clock::Clock, arg1: &mut Treasury, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (!0x2::object_table::contains<address, Wallet>(&arg1.wallets, arg2)) {
            let v1 = Wallet{
                id                     : 0x2::object::new(arg7),
                address                : arg2,
                minting_limit          : 50,
                last_minting_period_ms : v0,
            };
            0x2::object_table::add<address, Wallet>(&mut arg1.wallets, arg2, v1);
        };
        let v2 = 0x2::object_table::borrow_mut<address, Wallet>(&mut arg1.wallets, arg2);
        if (v0 >= v2.last_minting_period_ms + 86400000) {
            int_set_minting_limit(v2, 50);
            v2.last_minting_period_ms = v0;
        };
        assert!(int_get_minting_limit(v2) > 0, 1);
        int_decrement_minting_limit(v2);
        let v3 = 0x2::url::new_unsafe_from_bytes(arg5);
        let v4 = Claim{
            id          : 0x2::object::new(arg7),
            name        : arg3,
            description : arg4,
            url         : v3,
            data        : arg6,
        };
        let v5 = ClaimCreatedEvent{
            claim_id    : 0x2::object::id<Claim>(&v4),
            recipient   : arg2,
            name        : arg3,
            description : arg4,
            url         : v3,
            data        : arg6,
        };
        0x2::event::emit<ClaimCreatedEvent>(v5);
        0x2::transfer::public_transfer<Claim>(v4, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MasterPower{id: 0x2::object::new(arg0)};
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            wallets : 0x2::object_table::new<address, Wallet>(arg0),
        };
        0x2::transfer::share_object<Treasury>(v1);
        0x2::transfer::transfer<MasterPower>(v0, @0xe8ca3aba889815422917bd88b043d930d4be09ca06214712114735bc795a66e6);
    }

    fun int_decrement_minting_limit(arg0: &mut Wallet) : bool {
        let v0 = arg0.minting_limit;
        if (v0 == 0) {
            return false
        };
        arg0.minting_limit = v0 - 1;
        true
    }

    fun int_get_minting_limit(arg0: &Wallet) : u64 {
        arg0.minting_limit
    }

    fun int_set_minting_limit(arg0: &mut Wallet, arg1: u64) {
        assert!(arg1 <= 50, 0);
        arg0.minting_limit = arg1;
    }

    // decompiled from Move bytecode v6
}

