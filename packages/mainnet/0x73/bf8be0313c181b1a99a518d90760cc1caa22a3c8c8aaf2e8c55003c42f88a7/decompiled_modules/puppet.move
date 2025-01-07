module 0x73bf8be0313c181b1a99a518d90760cc1caa22a3c8c8aaf2e8c55003c42f88a7::puppet {
    struct PUPPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPET>(arg0, 6, b"PUPPET", b"SuiPuppet", b"a $PUPPET for everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961395417.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPPET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

