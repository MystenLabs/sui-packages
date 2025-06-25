module 0x5dfe4af15bb0bbe16c8aca89b4edc5f2ec082990e27f036754aa8f93828adbb2::KarenWorldX2 {
    struct KARENWORLDX2 has drop {
        dummy_field: bool,
    }

    struct BurnEvent has copy, drop, store {
        amount: u64,
        owner: address,
    }

    struct AirdropRegistry has store, key {
        id: 0x2::object::UID,
        claims: 0x2::table::Table<address, bool>,
    }

    public entry fun burn_token(arg0: &mut 0x2::coin::TreasuryCap<KARENWORLDX2>, arg1: 0x2::coin::Coin<KARENWORLDX2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KARENWORLDX2>(arg0, arg1);
        let v0 = BurnEvent{
            amount : 0x2::coin::value<KARENWORLDX2>(&arg1),
            owner  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun claim_airdrop(arg0: &mut AirdropRegistry, arg1: &mut 0x2::coin::TreasuryCap<KARENWORLDX2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, bool>(&arg0.claims, v0)) {
            abort 0
        };
        0x2::table::add<address, bool>(&mut arg0.claims, v0, true);
        0x2::coin::mint_and_transfer<KARENWORLDX2>(arg1, arg2, v0, arg3);
    }

    fun init(arg0: KARENWORLDX2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARENWORLDX2>(arg0, 9, b"KARENX2", b"KarenWorldX2", b"Karen World Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARENWORLDX2>>(v1);
        let v3 = &mut v2;
        let v4 = mint_initial_supply(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KARENWORLDX2>>(v4, 0x2::tx_context::sender(arg1));
        let v5 = AirdropRegistry{
            id     : 0x2::object::new(arg1),
            claims : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<AirdropRegistry>(v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARENWORLDX2>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun mint_initial_supply(arg0: &mut 0x2::coin::TreasuryCap<KARENWORLDX2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KARENWORLDX2> {
        0x2::coin::mint<KARENWORLDX2>(arg0, 420690000000000000, arg1)
    }

    public entry fun new_airdrop_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropRegistry{
            id     : 0x2::object::new(arg0),
            claims : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_share_object<AirdropRegistry>(v0);
    }

    public entry fun transfer_token(arg0: &mut 0x2::coin::TreasuryCap<KARENWORLDX2>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KARENWORLDX2>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

