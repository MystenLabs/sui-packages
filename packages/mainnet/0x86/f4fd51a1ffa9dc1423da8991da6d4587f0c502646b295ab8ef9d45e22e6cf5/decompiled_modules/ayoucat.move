module 0x86f4fd51a1ffa9dc1423da8991da6d4587f0c502646b295ab8ef9d45e22e6cf5::ayoucat {
    struct AYOUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYOUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYOUCAT>(arg0, 6, b"AYOUCAT", b"ARENTYOUCAT", b"The cat who knows - you are", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250505_180436_393_edit_89697090710791_40520a899c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYOUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYOUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

