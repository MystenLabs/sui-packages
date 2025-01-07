module 0xa93d93f423b4b4fe5c125e8ed096d49b7b355eab0d166f47c06d7e4ace7c32f5::weiner {
    struct WEINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEINER>(arg0, 6, b"WEINER", b"Weiner Sui", x"245745494e455220697320666f72207269636820626967206469636b73206f6e6c792c206a656574206d6963726f7765696e6572732063616e2066616465207468697320616e64206d697373206f7574206f6e20686176696e67206120626967206469636b20616e64206c6f7473206f66206d6f6e65790a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048725_dd6cd75742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEINER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEINER>>(v1);
    }

    // decompiled from Move bytecode v6
}

