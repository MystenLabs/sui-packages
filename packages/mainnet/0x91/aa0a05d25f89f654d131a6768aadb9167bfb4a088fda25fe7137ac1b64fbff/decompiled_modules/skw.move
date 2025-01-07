module 0x91aa0a05d25f89f654d131a6768aadb9167bfb4a088fda25fe7137ac1b64fbff::skw {
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

