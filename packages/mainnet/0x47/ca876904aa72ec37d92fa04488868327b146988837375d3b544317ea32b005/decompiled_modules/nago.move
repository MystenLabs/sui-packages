module 0x47ca876904aa72ec37d92fa04488868327b146988837375d3b544317ea32b005::nago {
    struct NAGO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NAGO>>(0x2::coin::mint<NAGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGO>(arg0, 6, b"NAGO", b"NAGO Coin", b"Official currency of the NAGO ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cyberpunkcat.s3.ap-southeast-1.amazonaws.com/nago.png"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

