module 0xad9ea0cd06368418bfff31dbe5f908e60b1b682973b730c1311e17c0c9e742b::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"kingai", b"This is KAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQMLty9ifwLyMxM23HGD2M5wXQ4AuocGiBZv9JBpCHmxC/5.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KAI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

