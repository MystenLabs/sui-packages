module 0xdf3a756bcc0051987e866609c05c938dbcfabbf62af64f2865a5c5d619f4bfa::marqual {
    struct MARQUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARQUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARQUAL>(arg0, 9, b"MARQUAL", b"Margaret Qualley", b"Born: October 23, 1994, Kalispell, MT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/MARQUAL.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARQUAL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARQUAL>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARQUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

