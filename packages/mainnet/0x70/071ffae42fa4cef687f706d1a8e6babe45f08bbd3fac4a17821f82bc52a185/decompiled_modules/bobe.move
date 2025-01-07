module 0x70071ffae42fa4cef687f706d1a8e6babe45f08bbd3fac4a17821f82bc52a185::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"BOOK OF BILLIONAIRES", b"Missed out on $BOME? Buckle up, because $BOBE is the VIP pass to the world where only the richor those destined to bedare to meme. This isnt for the faint of wallet. Were here to laugh, to dream big, and to say no thanks to brokies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vjf_J4l9_Z_400x400_5d6ef3bb2a_3f7e12b3cc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

