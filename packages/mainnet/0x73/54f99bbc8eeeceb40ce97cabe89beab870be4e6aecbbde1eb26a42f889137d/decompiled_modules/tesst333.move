module 0x7354f99bbc8eeeceb40ce97cabe89beab870be4e6aecbbde1eb26a42f889137d::tesst333 {
    struct TESST333 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESST333, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESST333>(arg0, 6, b"TESST333", b"test333", b"only test dont ape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibpemqezd3fofv7jygc45gg4d4cuq2uhmi5rf5rerevox4sympsl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESST333>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESST333>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

