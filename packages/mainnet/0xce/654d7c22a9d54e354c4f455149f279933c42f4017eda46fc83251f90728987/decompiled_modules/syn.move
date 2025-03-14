module 0xce654d7c22a9d54e354c4f455149f279933c42f4017eda46fc83251f90728987::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"Syna token", b"$SYN has officially launched", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profil_2d851d426f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

