module 0x60b842b925354c2475ad82af72739ef0199e23df9a1bf5dcaa73d117048ce45d::skw {
    struct SKW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKW>(arg0, 6, b"SKW", b"SUI KILLED WINDOWS", b"The goal is to kill windows, Join the Cult, It's a Cult! Join this Adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000397035_088f2947a7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKW>>(v1);
    }

    // decompiled from Move bytecode v6
}

