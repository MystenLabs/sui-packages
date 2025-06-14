module 0x50308dc100a64739c086cd84e799055777b0b2bbbb4ec6e6669ebed038006baf::drago {
    struct DRAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGO>(arg0, 6, b"DRAGO", b"LitchDragonSui", b"Not just any dragon, this is the strongest dragon that has ever existed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnc3t7iptcqzhlqh66zql3rxi46xcmfv4ur3yoyq26fl6s67u3a4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DRAGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

