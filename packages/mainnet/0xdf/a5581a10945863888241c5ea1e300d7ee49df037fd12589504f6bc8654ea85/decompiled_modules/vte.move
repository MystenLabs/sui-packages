module 0xdfa5581a10945863888241c5ea1e300d7ee49df037fd12589504f6bc8654ea85::vte {
    struct VTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTE>(arg0, 9, b"VTE", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreihbeqqcphnt5356uh43becdgr556lspaahyoo4mxshtzxe7ih4qde.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VTE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<VTE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

