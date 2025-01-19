module 0x61743a7e1a3e1a83189909a90282c556f77af5549bb7004491e3881a0e92de7b::gypsui {
    struct GYPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYPSUI>(arg0, 6, b"GYPSUI", b"Gypsui", b"The most gangsta coin on the block. Straight from the ghetto for real hustlers only!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_10_01_26_21_89602c0710.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

