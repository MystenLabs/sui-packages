module 0xdf2fa8b4befee8bf25acde5c5a82a78eb9fc6c58e48f88f16c3bbe9f2bd86ee::picasso {
    struct PICASSO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICASSO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICASSO>(arg0, 9, b"PICASSO", x"f09f96bcefb88f205049434153534f", b"Official token of Picasso", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/474x/f5/f4/46/f5f446ffba0c5f083ef6cbfee8254639.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PICASSO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICASSO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICASSO>>(v1);
    }

    // decompiled from Move bytecode v6
}

