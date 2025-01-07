module 0x2329e967730314dc01e2e017308227517071deca062895cab5a2d05107ae3991::bnt {
    struct BNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNT>(arg0, 6, b"BNT", b"Blocknation Token", b"This is a Blocknation loyalty meme coin that serves one purpose, build together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732530811047.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

