module 0xd79a3ff6f2d15bb2749238036f7ae67815f99ac5b2691feba033cd2539d36a29::b_tes {
    struct B_TES has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TES>(arg0, 9, b"bTES", b"bToken TES", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TES>>(v1);
    }

    // decompiled from Move bytecode v6
}

