module 0x5cd24843c6d58a039b103d976e165d1a8818b69c6624f76ced791e177dfa2d17::nbrgr {
    struct NBRGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBRGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBRGR>(arg0, 6, b"NBRGR", b"Nothing Burger", b"Nothing Burger is a new project on Sui about nothing. Nothing Burger aims to achieve nothing. If you want to support an NFT collection about nothing burgers take a bite. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748131634088.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NBRGR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBRGR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

