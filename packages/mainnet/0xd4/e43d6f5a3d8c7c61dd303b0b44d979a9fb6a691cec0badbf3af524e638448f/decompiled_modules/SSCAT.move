module 0xd4e43d6f5a3d8c7c61dd303b0b44d979a9fb6a691cec0badbf3af524e638448f::SSCAT {
    struct SSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCAT>(arg0, 9, b"SSCAT", b"SUI SAIYAN CAT", b"SUI SAIYAN CAT, building the most vibrant memecoin community of SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"ipfs://QmNSWzwepnC27Q63kMKKbcc4P8FNeqYWGKB2VsTJZTrnbn/uMMomHlF_400x400%20(1).jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SSCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SSCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

