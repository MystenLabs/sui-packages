module 0x8a85bd1f5ec59457f4c3b28753bd5cd3dc2bc16e41348d6fef98788bea166a37::row {
    struct ROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROW>(arg0, 6, b"ROW", b"ROW", b"wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeicgligwn4lgdpvhwya3evrm4xw5klnjim4bjg2plrs2meyxr2gymm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROW>>(v2, @0xfe65cf3f401586ad76108d97b4a49fa382c3b16235f36e0fc972035b25414e9e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

