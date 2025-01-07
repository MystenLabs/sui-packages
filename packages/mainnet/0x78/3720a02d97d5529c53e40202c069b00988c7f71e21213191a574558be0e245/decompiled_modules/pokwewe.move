module 0x783720a02d97d5529c53e40202c069b00988c7f71e21213191a574558be0e245::pokwewe {
    struct POKWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKWEWE>(arg0, 9, b"POKWEWE", b"POKE", b"This coin to support pokemon community, if you love pokemon , please buy this coin thank you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b789e5a-fd19-4042-8ddf-7fa652aff6b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

