module 0x2983e6027cc7e78d9975599ded428954197baa2794a3e67f2fd79c4b9c0dc82::igor {
    struct IGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGOR>(arg0, 6, b"IGOR", b"Igor Tiger On Sui", b"IGOR Old Friend of Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Avatar_3d9efb687b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

