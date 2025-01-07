module 0x2bfd6c717b11cc47de9c346ab9a8bf4a4632867953a4f13e976418ebd942aadb::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 6, b"BUU", b"BUU COIN ON SUI", b"BUU COIN WILL BE THE NEXT MILLIONS CAP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_x_b5bffe4618.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

