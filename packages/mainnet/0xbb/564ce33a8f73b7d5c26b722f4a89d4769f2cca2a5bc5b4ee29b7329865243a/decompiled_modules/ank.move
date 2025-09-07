module 0xbb564ce33a8f73b7d5c26b722f4a89d4769f2cca2a5bc5b4ee29b7329865243a::ank {
    struct ANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANK>(arg0, 9, b"ANK", b"anik.eth", b"Pointal 1000X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANK>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANK>>(v2, @0xb80db8a85fa2ec3710c1d198fb5e89069d83f55ec1d67ac52f2bb9aea793f0d8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

