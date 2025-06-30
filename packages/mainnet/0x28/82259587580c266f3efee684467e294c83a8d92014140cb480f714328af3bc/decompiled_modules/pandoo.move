module 0x2882259587580c266f3efee684467e294c83a8d92014140cb480f714328af3bc::pandoo {
    struct PANDOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDOO>(arg0, 6, b"PANDOO", b"Pandoo The Meme Pand", x"2450414e444f4f2069732074686520637574657374206d656d652070616e6461206f6e2053756920626c6f636b636861696e20f09f90bc20200a4e6f2074617865732c206e6f2072756720e28094206a75737420707572652070616e646120706f7765722120200a4a6f696e20757320616e642062652070617274206f66207468652050616e646f6f206d6f76656d656e7420f09f8c95f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1751315712927.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

