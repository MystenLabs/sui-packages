module 0x2cb71b9fdd4477f04ad529fe3b48838ec832117d7a741ed8c4404ca375295b5::cap {
    struct CAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAP>(arg0, 6, b"CAP", b"caponsui", b"Lost everything using leverage, now I spot and chil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAP_a6abbda536.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

