module 0xd7856bc3f5e989504ae61f584fdbd5af736cd2dde83a8b9400a0fe1f2915cbda::moli {
    struct MOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOLI>(arg0, 6, b"MOLI", b"MOLISUI", b"$MOLI emerged quietly, grew silently, and achieved dazzling success, leaving the crowd astonished. Let's welcome $MOLI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_13_16_09_b9cda57590.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

