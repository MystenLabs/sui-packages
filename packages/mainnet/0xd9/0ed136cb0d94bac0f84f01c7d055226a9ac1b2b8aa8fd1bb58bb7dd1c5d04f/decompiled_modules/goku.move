module 0xd90ed136cb0d94bac0f84f01c7d055226a9ac1b2b8aa8fd1bb58bb7dd1c5d04f::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"GokuMemeSUI", x"476f6b75206d656d65206f6e200a405375694e6574776f726b0a2e204c697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730958507066.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

