module 0x821d92225ea74c30eb2f7f400b32df19fad0ee46bafd032e591c28e9f355a6e2::str {
    struct STR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STR>(arg0, 9, b"STR", b"STARS", x"546865207368696e696e67206469676974616c2063757272656e6379206f66207468652062656175747920616e64206d797374657279206f662074686520756e6976657273650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ae856a3-c79c-4a8f-bd7c-e9cbab17fa1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STR>>(v1);
    }

    // decompiled from Move bytecode v6
}

