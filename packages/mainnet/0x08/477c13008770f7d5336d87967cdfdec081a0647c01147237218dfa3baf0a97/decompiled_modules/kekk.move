module 0x8477c13008770f7d5336d87967cdfdec081a0647c01147237218dfa3baf0a97::kekk {
    struct KEKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKK>(arg0, 9, b"KEKK", b"Cekk", b"Am", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/254974b5-5330-473a-83dd-71748e44a91f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

