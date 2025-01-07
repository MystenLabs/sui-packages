module 0xdae3e1b4f7732879a19becb0e58f4539a4470e6e981cb307e053e9af7a19b890::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 6, b"Ball", b"Cheems", b"Why so serious?? Woof!! Woof!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240809_225600_4c0c5dfec8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

