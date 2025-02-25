module 0xda781a2547940fe382f391cb39b53413fa329c144b79a16bd3852059211be7c0::etd {
    struct ETD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETD>(arg0, 9, b"ETD", b"Eth Denver", b"A token for the Eth Denver community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETD>>(v1);
    }

    // decompiled from Move bytecode v6
}

