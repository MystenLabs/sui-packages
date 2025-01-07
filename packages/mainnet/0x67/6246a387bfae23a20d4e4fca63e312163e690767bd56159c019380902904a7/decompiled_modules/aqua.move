module 0x676246a387bfae23a20d4e4fca63e312163e690767bd56159c019380902904a7::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"Akwamern on Sui", x"43616c6c696e6720616c6c20646567656e732e2048656c7020796f75722072657461726465642c20776174657220627265617468696e672053756920706572206865726f2066696e642041746c616e7469732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6109_63c860db18.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

