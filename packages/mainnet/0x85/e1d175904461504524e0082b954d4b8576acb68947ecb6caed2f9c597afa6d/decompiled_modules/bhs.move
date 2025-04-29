module 0x85e1d175904461504524e0082b954d4b8576acb68947ecb6caed2f9c597afa6d::bhs {
    struct BHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHS>(arg0, 6, b"BHS", b"Sui Black Hat", b"Grab your hat as long as it is black.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250430_012019_8b60229a66.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

