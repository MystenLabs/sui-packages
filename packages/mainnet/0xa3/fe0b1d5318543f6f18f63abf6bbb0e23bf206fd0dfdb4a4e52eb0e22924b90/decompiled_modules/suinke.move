module 0xa3fe0b1d5318543f6f18f63abf6bbb0e23bf206fd0dfdb4a4e52eb0e22924b90::suinke {
    struct SUINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINKE>(arg0, 6, b"Suinke", b"Sui Ponke", b"Ponke on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731016978593.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

