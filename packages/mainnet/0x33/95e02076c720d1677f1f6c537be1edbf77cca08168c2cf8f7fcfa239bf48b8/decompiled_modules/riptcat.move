module 0x3395e02076c720d1677f1f6c537be1edbf77cca08168c2cf8f7fcfa239bf48b8::riptcat {
    struct RIPTCAT has drop {
        dummy_field: bool,
    }

    public fun creator() : address {
        @0x8c0bc02fe303e0396c73336e574a109866e706f7629f3ddc3d5d6635484c871f
    }

    fun init(arg0: RIPTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<RIPTCAT>(arg0, 9, 0x1::string::utf8(b"RIPTCAT"), 0x1::string::utf8(b"Riptcat"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://gateway.pinata.cloud/ipfs/bafybeidpmhfky66ecoqyqgjgdujh3nvdqjdr6fihk4sh5ukmz3qbs22gfi"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPTCAT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<RIPTCAT>>(0x2::coin_registry::finalize<RIPTCAT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

