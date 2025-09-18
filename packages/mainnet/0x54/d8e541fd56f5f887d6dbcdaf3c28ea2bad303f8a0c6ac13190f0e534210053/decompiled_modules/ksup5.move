module 0x54d8e541fd56f5f887d6dbcdaf3c28ea2bad303f8a0c6ac13190f0e534210053::ksup5 {
    struct KSUP5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUP5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUP5>(arg0, 6, b"KSUP5", b"5k sup", b"5ksup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibpemqezd3fofv7jygc45gg4d4cuq2uhmi5rf5rerevox4sympsl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUP5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KSUP5>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

