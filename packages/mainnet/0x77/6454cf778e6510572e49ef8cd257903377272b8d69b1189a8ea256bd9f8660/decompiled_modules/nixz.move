module 0x776454cf778e6510572e49ef8cd257903377272b8d69b1189a8ea256bd9f8660::nixz {
    struct NIXZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIXZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIXZ>(arg0, 9, b"NIXZ", b"JINX", b" X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be32a391-91ae-4fed-8c46-c7ffadc274ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIXZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIXZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

