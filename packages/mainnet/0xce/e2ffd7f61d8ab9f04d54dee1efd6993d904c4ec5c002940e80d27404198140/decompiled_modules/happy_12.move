module 0xcee2ffd7f61d8ab9f04d54dee1efd6993d904c4ec5c002940e80d27404198140::happy_12 {
    struct HAPPY_12 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPPY_12, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPPY_12>(arg0, 9, b"HAPPY_12", b"Happy", b"Happy token is a token that enhance the sui ecosystem. To have fun and make money. Lfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bf3deb6-79de-40de-83cd-8b901f3721f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPPY_12>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAPPY_12>>(v1);
    }

    // decompiled from Move bytecode v6
}

