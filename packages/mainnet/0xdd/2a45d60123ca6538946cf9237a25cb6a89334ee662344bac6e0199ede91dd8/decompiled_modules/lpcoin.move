module 0xdd2a45d60123ca6538946cf9237a25cb6a89334ee662344bac6e0199ede91dd8::lpcoin {
    struct LPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LPCOIN>(arg0, 6, b"LPCoin", b"LPCoin SUI-USDC-60", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://jg27bwnonfu362hdmr2runpgtn3t2xibza2acy6ra7leeoa6wjga.arweave.net/SbXw2a5pab9o42R1GjXmm3c9XQHINAFj0QfWQjgeskw")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LPCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

