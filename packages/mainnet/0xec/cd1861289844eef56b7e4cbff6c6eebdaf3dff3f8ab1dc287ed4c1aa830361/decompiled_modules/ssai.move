module 0xeccd1861289844eef56b7e4cbff6c6eebdaf3dff3f8ab1dc287ed4c1aa830361::ssai {
    struct SSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSAI>(arg0, 6, b"SSAI", b"SuiSenseAI", b"SuiSenseAI is an intelligent guide for the Sui blockchain, simplifying complex ideas and delivering key insights to Sui enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737028280818.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

