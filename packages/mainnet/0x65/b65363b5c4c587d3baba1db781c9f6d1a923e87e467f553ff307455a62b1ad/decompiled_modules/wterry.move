module 0x65b65363b5c4c587d3baba1db781c9f6d1a923e87e467f553ff307455a62b1ad::wterry {
    struct WTERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTERRY>(arg0, 6, b"wTERRY", b"Wrapped Terry", x"2457544552525920577261707065642054657272792065617473204154487320616e6420706f6f707320677265656e2063616e646c65732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Terry_9c27963ab1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

