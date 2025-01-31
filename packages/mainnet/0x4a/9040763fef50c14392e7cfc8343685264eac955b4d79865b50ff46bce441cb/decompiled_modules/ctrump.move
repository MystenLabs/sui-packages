module 0x4a9040763fef50c14392e7cfc8343685264eac955b4d79865b50ff46bce441cb::ctrump {
    struct CTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRUMP>(arg0, 9, b"CTRUMP", b"C.Trump", b"This is a coin to acknowledge President Trump a True Hero.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc262e23-98f5-443c-880a-979ad3787456.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

