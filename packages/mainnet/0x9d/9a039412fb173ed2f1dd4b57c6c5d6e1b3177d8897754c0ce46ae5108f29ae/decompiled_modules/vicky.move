module 0x9d9a039412fb173ed2f1dd4b57c6c5d6e1b3177d8897754c0ce46ae5108f29ae::vicky {
    struct VICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VICKY>(arg0, 9, b"VICKY", b"Shiba Inu's Daughter", x"5669636b792c20536869626120496e7527732062656c6f7665642064617567687465722e20245649434b590d0a0d0a68747470733a2f2f742e6d652f5669636b7953686962610d0a0d0a68747470733a2f2f782e636f6d2f4972696e6156616c6b6f373932302f7374617475732f31383735333838393838323333383036303431", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW6d3bvEwS5P6bm8qtVP6CTSoyuDcPSXoBAAhqTXZ6mwq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VICKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VICKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VICKY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

