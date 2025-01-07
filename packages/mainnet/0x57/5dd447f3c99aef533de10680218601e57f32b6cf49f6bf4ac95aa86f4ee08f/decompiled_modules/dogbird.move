module 0x575dd447f3c99aef533de10680218601e57f32b6cf49f6bf4ac95aa86f4ee08f::dogbird {
    struct DOGBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBIRD>(arg0, 6, b"DOGBIRD", b"DOGBIRD Sui", b"$DOGBIRD IS A MEME COIN ON SUI BLOCKCHAIN WITH NEW FEATURE AND UTILITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000236_275c6db3bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

