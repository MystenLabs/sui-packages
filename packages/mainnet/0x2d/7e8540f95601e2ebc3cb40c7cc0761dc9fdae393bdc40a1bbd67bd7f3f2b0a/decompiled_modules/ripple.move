module 0x2d7e8540f95601e2ebc3cb40c7cc0761dc9fdae393bdc40a1bbd67bd7f3f2b0a::ripple {
    struct RIPPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPPLE>(arg0, 6, b"RIPPLE", b"RIPPLESUI", x"526970706c6520585250206973206e756d626572206f6e65206d656d65206f6e2054696b546f6b207269676874206e6f772c20616e6420697427732074696d6520666f7220524950504c4520746f20646f6d696e617465206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241202_163904_2_8e1c963475.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

