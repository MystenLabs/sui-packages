module 0x34a1eda09cd14ad3b1d471e5507e528e92e9b22135ec50cb8bceff5d7d822a74::cup {
    struct CUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUP>(arg0, 6, b"CUP", b"CUP WITHOUT HANDLE", b"CUP WITHOUT HANDLE IS COMING TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9debb9bd1e4a4c598198d0ead29e5c87_e9ec6985ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

