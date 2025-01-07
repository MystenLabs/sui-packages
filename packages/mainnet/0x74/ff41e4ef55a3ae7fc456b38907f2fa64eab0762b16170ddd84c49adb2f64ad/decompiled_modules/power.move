module 0x74ff41e4ef55a3ae7fc456b38907f2fa64eab0762b16170ddd84c49adb2f64ad::power {
    struct POWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWER>(arg0, 9, b"POWER", b"POSSUMS ", b"POSSUMS is a meme inspired by the spirit of adventure and freedom with possums, we are not just riding the waves we are mastering thems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16220e6b-4f40-423a-8999-375e9c826281.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POWER>>(v1);
    }

    // decompiled from Move bytecode v6
}

