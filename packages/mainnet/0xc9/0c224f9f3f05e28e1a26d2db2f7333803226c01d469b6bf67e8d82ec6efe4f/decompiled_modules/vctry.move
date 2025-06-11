module 0xc90c224f9f3f05e28e1a26d2db2f7333803226c01d469b6bf67e8d82ec6efe4f::vctry {
    struct VCTRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: VCTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VCTRY>(arg0, 6, b"VCTRY", b"Victory", b"V FOR THE  VICTORY !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigxg4ism6yfwt24oyt2qtpqlfvjmpnne2tqaoffxcfcdlnamat4hi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VCTRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VCTRY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

