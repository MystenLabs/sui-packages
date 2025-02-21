module 0xdc156bff5025ef4467789b77c52077421640cd02c30e0140be049adb489a4a10::sSCA {
    struct SSCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCA>(arg0, 6, b"sysSCA", b"SY sSCA", b"SY scallop sSCA", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSCA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

