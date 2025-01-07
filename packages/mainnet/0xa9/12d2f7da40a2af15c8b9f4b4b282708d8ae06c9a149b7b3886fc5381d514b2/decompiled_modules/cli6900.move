module 0xa912d2f7da40a2af15c8b9f4b4b282708d8ae06c9a149b7b3886fc5381d514b2::cli6900 {
    struct CLI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLI6900>(arg0, 6, b"CLI6900", b"Crying Leftists Index 6900", b"The best-performing index since November 6, 2024. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIF_221b995db8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

