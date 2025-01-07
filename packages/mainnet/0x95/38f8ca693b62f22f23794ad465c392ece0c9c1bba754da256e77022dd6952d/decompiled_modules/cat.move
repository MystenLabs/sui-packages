module 0x9538f8ca693b62f22f23794ad465c392ece0c9c1bba754da256e77022dd6952d::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CAT>(arg0, 6, b"CAT", b"AI CAT", b"First model of CAT AI..Secret will be reveal after 20 January 2025 ( Donald Trump offcicial step in White House)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000057641_196e798bb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

