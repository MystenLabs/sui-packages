module 0x3769b870210accca47dfc16935256c94ecee499370770e96650a3d2fb0d72f8a::dulk {
    struct DULK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DULK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DULK>(arg0, 9, b"DULK", b"ryjsktl", b"aftjk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f84bae164a1b5567eccb145ce8041123blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DULK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DULK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

