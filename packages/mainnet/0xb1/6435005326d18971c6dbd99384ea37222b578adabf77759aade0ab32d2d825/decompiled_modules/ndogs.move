module 0xb16435005326d18971c6dbd99384ea37222b578adabf77759aade0ab32d2d825::ndogs {
    struct NDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDOGS>(arg0, 9, b"NDOGS", b"N-Dogs ", b"NDogs Comunity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/333dd03f-e826-4194-9e16-3b91e6025a2c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

