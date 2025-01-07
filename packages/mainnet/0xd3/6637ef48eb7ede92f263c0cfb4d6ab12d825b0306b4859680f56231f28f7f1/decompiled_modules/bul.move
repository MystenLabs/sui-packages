module 0xd36637ef48eb7ede92f263c0cfb4d6ab12d825b0306b4859680f56231f28f7f1::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 9, b"BUL", b"Bullion Buck", b"It's Bullion Buck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUL>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v2, @0xc41fe29746367c7f4ba05ed387f1a446f4c304c31fa5bf45c566726061cccc19);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

