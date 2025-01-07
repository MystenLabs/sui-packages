module 0x355eafb826e83c2c328e64962cccb3bd83ec99ed17b5784688400e1706c0ec5a::tkd {
    struct TKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKD>(arg0, 9, b"TKD", b"TUKUDA", b"MEME TUKUDA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b8875dd-7fdc-4cc2-bba6-e2b7a3df9a53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

