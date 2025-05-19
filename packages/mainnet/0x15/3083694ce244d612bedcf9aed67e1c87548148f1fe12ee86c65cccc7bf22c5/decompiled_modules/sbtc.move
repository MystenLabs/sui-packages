module 0x153083694ce244d612bedcf9aed67e1c87548148f1fe12ee86c65cccc7bf22c5::sbtc {
    struct SBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTC>(arg0, 9, b"Sbtc", b"Sui btc", b"Bitcoin on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/855b079eb2b40c5684f815c0f3d774cfblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

