module 0x5e120252b38437ef3b0ccd226426b4f32311329e90827bea3d75d5e393ed7d83::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZY>(arg0, 6, b"JOOZY", b"JOOZY AI", b"1st AI Assistant on SUI network. Dapps that has revolutionized the way people interact with the Web3. With its features, allows users to seamlessly interact.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_01_19_31f76a907d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

