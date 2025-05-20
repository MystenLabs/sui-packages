module 0x3b66d3efbc58369590da65756808912a8bbd1eb036384c33c4e6034e334416d1::sply {
    struct SPLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLY>(arg0, 6, b"SPLY", b"SPLASHY", b"The new number 1 Sui that roam around the sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7huoemjtrlslgii7nfej3m6xmebcjnttngna2f4mjvuqgrbr45a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

