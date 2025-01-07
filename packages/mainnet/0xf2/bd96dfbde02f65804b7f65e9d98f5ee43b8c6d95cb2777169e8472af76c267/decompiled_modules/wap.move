module 0xf2bd96dfbde02f65804b7f65e9d98f5ee43b8c6d95cb2777169e8472af76c267::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Cardi B Cat", b"We are the WAP of the Water chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1934_fbcdf61883.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

