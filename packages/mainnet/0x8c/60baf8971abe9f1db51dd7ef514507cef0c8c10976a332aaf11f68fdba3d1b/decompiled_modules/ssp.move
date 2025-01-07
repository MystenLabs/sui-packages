module 0x8c60baf8971abe9f1db51dd7ef514507cef0c8c10976a332aaf11f68fdba3d1b::ssp {
    struct SSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSP>(arg0, 6, b"SSP", b"STARSHIP", b"Happens often!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088781_256867bc41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

