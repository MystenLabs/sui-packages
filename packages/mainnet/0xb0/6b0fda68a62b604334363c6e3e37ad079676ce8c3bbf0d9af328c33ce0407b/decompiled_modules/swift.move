module 0xb06b0fda68a62b604334363c6e3e37ad079676ce8c3bbf0d9af328c33ce0407b::swift {
    struct SWIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFT>(arg0, 6, b"SWIFT", b"SUISWIFT", b"BEAUTIFUL DOG OF THE SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic2lav5aapwwqqz5azbzgzruetg63ux4frtzpseu3geqaoqe6pw3i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SWIFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

