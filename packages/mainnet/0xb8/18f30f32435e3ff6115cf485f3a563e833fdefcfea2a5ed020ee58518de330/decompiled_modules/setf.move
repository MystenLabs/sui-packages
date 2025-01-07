module 0xb818f30f32435e3ff6115cf485f3a563e833fdefcfea2a5ed020ee58518de330::setf {
    struct SETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SETF>(arg0, 9, b"SETF", b"SuiETF", b"SuiETF is a token that provides diversified exposure to top Sui blockchain projects, offering a simple way to invest in multiple assets like DeFi through a single token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1435574456500428801/4-vNGB3Z.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SETF>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SETF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SETF>>(v1);
    }

    // decompiled from Move bytecode v6
}

