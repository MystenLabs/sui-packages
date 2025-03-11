module 0xee2a7fb55fd618cf2a9c45836b13a7c9c9231d22609d48046be3101c43fde60d::suby {
    struct SUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBY>(arg0, 6, b"SUBY", b"Suby on Sui", b"Suby is a leading meme coin within the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1741724466153.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUBY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

