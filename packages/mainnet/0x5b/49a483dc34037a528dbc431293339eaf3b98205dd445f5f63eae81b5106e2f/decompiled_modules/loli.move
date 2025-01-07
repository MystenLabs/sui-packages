module 0x5b49a483dc34037a528dbc431293339eaf3b98205dd445f5f63eae81b5106e2f::loli {
    struct LOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLI>(arg0, 6, b"LOLI", b"Lollipop", x"f09f8dad205377656574657374206d656d6520746f6b656e206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731102153091.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

