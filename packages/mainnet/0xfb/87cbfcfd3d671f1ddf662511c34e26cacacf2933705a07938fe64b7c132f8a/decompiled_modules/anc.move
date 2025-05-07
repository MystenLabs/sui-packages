module 0xfb87cbfcfd3d671f1ddf662511c34e26cacacf2933705a07938fe64b7c132f8a::anc {
    struct ANC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANC>(arg0, 6, b"ANC", b"THE ANCHOR", b"DEV Supply forever BURNED NOT LOCKED, NO PRESALE, NO DEV WALLET just pure $ANC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibme7426avjmitg2b2w5wtoo36tp4gex7u5leho47qaqreqtkrgxu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

