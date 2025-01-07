module 0x8455e07f637e2c51cd4a354eb1b940a2a0072361f74ac398d38f3ac265d6c366::cis {
    struct CIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CIS>(arg0, 6, b"CIS", b"CommunityIn Service by SuiAI", b"Community in Service (CIS) refers to the community storing their spending in rewards and letting them use profits to build the community and keep them away from profit greedy firms. Community in Service owners have community pool ownership in products and services provided by CIS entities. This is a project in the works, think of it of social capitalism on steroids. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BURND_Logo_648cfb4d0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

