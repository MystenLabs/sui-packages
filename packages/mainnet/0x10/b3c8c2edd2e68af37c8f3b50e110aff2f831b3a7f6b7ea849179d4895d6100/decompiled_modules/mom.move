module 0x10b3c8c2edd2e68af37c8f3b50e110aff2f831b3a7f6b7ea849179d4895d6100::mom {
    struct MOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOM>(arg0, 9, b"MOM", b"Museum Of Memes", b"Museum of Memes: Explore the Fun and Future of Memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVQ1bWJmna3vbFCRMTGJknJRs1SMJGESXV658JjDchgUM")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

