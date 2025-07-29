module 0x3bdc23fb2ddacf25b542060a0c7c80cece532208b32267e6039f8a0e9e88d1a1::gents {
    struct GENTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENTS>(arg0, 6, b"GENTS", b"Gentora S", b"Shaping the future job opportunities on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieher4nqzkdgthjxi2sp4uv7rgjw4cuzhwgriiltvrokbxjznmafu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

