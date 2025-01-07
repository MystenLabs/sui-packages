module 0xf8f780de70044587f40e980f228816e101967b595b5aac958df25c27622af6b0::rpepe {
    struct RPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPEPE>(arg0, 6, b"RPEPE", b"Ranger Pepe", b"Are you ready to unleash the power of Pepe and the Rangers? Join the $PRPepe revolution today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_14_11_23_19_87648d3522.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

