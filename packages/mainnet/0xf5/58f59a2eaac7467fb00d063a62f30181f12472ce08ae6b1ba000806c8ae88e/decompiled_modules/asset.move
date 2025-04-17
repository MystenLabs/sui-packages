module 0xf558f59a2eaac7467fb00d063a62f30181f12472ce08ae6b1ba000806c8ae88e::asset {
    struct ASSET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSET>(arg0, 9, b"ASSET", b"ASSET On Sui", b"most valuable asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRD6eQcvyRLwLhEYAZYZsGZ2kGeaYpLehj1bP4CcduPYV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASSET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASSET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSET>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

