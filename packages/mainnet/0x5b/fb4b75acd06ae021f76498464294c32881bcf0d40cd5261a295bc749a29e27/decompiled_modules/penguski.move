module 0x5bfb4b75acd06ae021f76498464294c32881bcf0d40cd5261a295bc749a29e27::penguski {
    struct PENGUSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUSKI>(arg0, 6, b"PENGUSKI", b"Ski Mask Pengu Sui", b"Ski mask pengu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicyeonqiqemr7ksmesnasln3t6jswh6hgcen6zwfqvwf7smn3z4pi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUSKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PENGUSKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

