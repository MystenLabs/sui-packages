module 0x426d8aca9153dff43e5951c8a28eb7a6f75aae0669b07e350ef098bb3923c079::chesy {
    struct CHESY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHESY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHESY>(arg0, 6, b"CHESY", b"Sui Chesy", b"The cute fat wizard cat as chesy on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiezetevwdsbmm5piujgpa77fapuradf2e5ytpf73zguj26qtbypgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHESY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHESY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

