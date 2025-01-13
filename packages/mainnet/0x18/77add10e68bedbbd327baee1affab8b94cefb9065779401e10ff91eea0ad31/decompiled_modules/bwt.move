module 0x1877add10e68bedbbd327baee1affab8b94cefb9065779401e10ff91eea0ad31::bwt {
    struct BWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BWT>(arg0, 6, b"BWT", b"BWT alpineF1 by SuiAI", b"Alpine ushers in a new era with the launch of the A290 Explore new areas and create the strongest BWT token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2116_fa6360046d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

