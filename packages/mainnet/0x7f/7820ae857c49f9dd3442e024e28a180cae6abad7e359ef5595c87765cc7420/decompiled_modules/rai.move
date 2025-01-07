module 0x7f7820ae857c49f9dd3442e024e28a180cae6abad7e359ef5595c87765cc7420::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAI>(arg0, 9, b"RAI", b"RaiCoin ", b"RaiCoin is one of the best ones crypto coin in upcoming time. Please trade trustfully. It will be the best coin in 2026.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42b20d67-032a-4557-a7b2-6df57406c8bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

