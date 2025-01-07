module 0xb5a6c5eb12dac849867c5d361fa14b5ee658ad3a50271fc991545aeb631ec584::bsully {
    struct BSULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSULLY>(arg0, 9, b"BSULLY", b"Baby Sully", x"f09fa690204d65657420746865206b696e67206f6620746865207365612e202453554c4c59206f6e202453554920f09fa690", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1841579959342473216/KNsTrIZ5_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BSULLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSULLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

