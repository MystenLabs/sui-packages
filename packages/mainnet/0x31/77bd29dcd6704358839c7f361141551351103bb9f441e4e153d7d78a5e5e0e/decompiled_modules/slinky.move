module 0x3177bd29dcd6704358839c7f361141551351103bb9f441e4e153d7d78a5e5e0e::slinky {
    struct SLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLINKY>(arg0, 6, b"Slinky", b"SlinkySui", b"Stretch your memes, stack your gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_082301038_69c38277fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

