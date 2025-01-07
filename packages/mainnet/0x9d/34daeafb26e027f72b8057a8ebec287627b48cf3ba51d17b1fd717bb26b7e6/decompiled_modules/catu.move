module 0x9d34daeafb26e027f72b8057a8ebec287627b48cf3ba51d17b1fd717bb26b7e6::catu {
    struct CATU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATU>(arg0, 6, b"CATU", b"CATU SUI", x"546865206769616e74206361742063756220636174752061742073756920536166617269205061726b20696e20737569210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_21_41_51_c7c7ce87cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATU>>(v1);
    }

    // decompiled from Move bytecode v6
}

