module 0xf3e61b844f4459e7d4174b9b4936f91ab85e7846edee02f1ecceed2692dba594::brook {
    struct BROOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROOK>(arg0, 6, b"BROOK", b"BROOK now in SUI", b"$BROOK inspired from Brock - is a Rock-type Pokemon gym leader. A carefree and joyful trainer that loves rocky Pokemon. He's here in the sea, will he engage?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia5iajl343cqna7ilavkkwduiyhwik7gfwtdoj45veif3fyulipvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROOK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

