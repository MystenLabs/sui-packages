module 0xb77b6b92cc9942f791ea0a832d41e67685ad840d15294fbaa27d52cf64a9d3fb::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 6, b"RT", b"RoboTaxi", b"Tesla's robotaxi service is part of Elon Musk's vision for autonomous ride-hailing. The concept involves using Tesla's electric vehicles (EVs) equipped with full self-driving (FSD) capabilities to operate as autonomous taxis.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_44a8cd503f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RT>>(v1);
    }

    // decompiled from Move bytecode v6
}

