module 0x5099c04368cae2ec1fdc6b5f7d720c81f66f293952171d72eab79f582131d264::tgr {
    struct TGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGR>(arg0, 9, b"TGR", b"Tigr", x"d0a2d0bed0bad0b5d0bd20d0b4d0bbd18f20d181d0b8d0bbd18cd0bdd18bd18520d0b4d183d185d0bed0bc2021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca677ff9-7bab-4ee4-8dad-1ffef53e1347.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

