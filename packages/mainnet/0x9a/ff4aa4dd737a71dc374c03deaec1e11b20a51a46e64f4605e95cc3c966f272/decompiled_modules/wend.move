module 0x9aff4aa4dd737a71dc374c03deaec1e11b20a51a46e64f4605e95cc3c966f272::wend {
    struct WEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEND>(arg0, 9, b"WEND", b"Wen Dexscreener", b"When will Dexscreener integrate FlowX Finance ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhmmxkynepjlechfvmkpcps35f2ayagaypg5gnqd4bnbeblyvdjm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WEND>(&mut v2, 100000000000000000, @0xc6fe73b04e84d84742069a78aeb9fa7163c116aa1249c90159fc947c5863745b, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEND>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WEND>>(v2);
    }

    // decompiled from Move bytecode v6
}

