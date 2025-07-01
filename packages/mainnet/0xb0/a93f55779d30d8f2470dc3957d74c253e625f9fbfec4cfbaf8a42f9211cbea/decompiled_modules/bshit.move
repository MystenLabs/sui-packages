module 0xb0a93f55779d30d8f2470dc3957d74c253e625f9fbfec4cfbaf8a42f9211cbea::bshit {
    struct BSHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHIT>(arg0, 6, b"BSHIT", b"bullshiet", b"test bullshiet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibpemqezd3fofv7jygc45gg4d4cuq2uhmi5rf5rerevox4sympsl4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BSHIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

