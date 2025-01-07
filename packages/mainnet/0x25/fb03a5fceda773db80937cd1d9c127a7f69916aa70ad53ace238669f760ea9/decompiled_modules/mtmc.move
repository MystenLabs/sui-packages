module 0x25fb03a5fceda773db80937cd1d9c127a7f69916aa70ad53ace238669f760ea9::mtmc {
    struct MTMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTMC>(arg0, 6, b"MTMC", b"Mike Tyson Meme coin", b"$MTMC is a decentralized meme coin build on  #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731783033977.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

