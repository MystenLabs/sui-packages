module 0x45e8cb6e11fd2dd6c7ae41353ff165d3771eedfbc18264134fd0e13d91b8ea60::hades {
    struct HADES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HADES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HADES>(arg0, 6, b"HADES", b"Suides", b"The god of the dead and the king of the underworld", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000214234_88156d0a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HADES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HADES>>(v1);
    }

    // decompiled from Move bytecode v6
}

