module 0x217fe5f55964c2de721110051f6c1dc25909c0d56147db985feee0553665c064::lamu {
    struct LAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMU>(arg0, 6, b"LAMU", b"LAMU MOROBOSHI", x"4c616dc3b920697320616e20616c69656e207072696e636573732066726f6d20706c616e6574204f6e69626f7368692c206b6e6f776e20666f722068657220677265656e20686169722c206361742d6c696b6520656172732c20616e642074696765722d737472697065642062696b696e692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731938811760.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

