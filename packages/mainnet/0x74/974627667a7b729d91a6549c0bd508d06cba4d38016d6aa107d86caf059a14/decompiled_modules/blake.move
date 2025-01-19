module 0x74974627667a7b729d91a6549c0bd508d06cba4d38016d6aa107d86caf059a14::blake {
    struct BLAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAKE>(arg0, 6, b"BLAKE", b"Sun Blake", b"sunblake is a memecoin with a mission to spread positivity and financial growth. Born from the energy of the sun, we aim to empower a decentralized community where everyone shines", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737307151318.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLAKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

