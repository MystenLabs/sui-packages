module 0xe64f7cc8ea858c0040eee39eea4683b3ff8cced177f405071834cbbc53f861fa::nenbd {
    struct NENBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NENBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NENBD>(arg0, 9, b"NENBD", b"Oendb", b"jekwk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ec07969-cfda-4703-aee1-47cfc786beb8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NENBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NENBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

