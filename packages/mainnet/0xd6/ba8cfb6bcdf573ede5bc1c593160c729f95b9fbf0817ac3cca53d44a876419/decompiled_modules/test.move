module 0xd6ba8cfb6bcdf573ede5bc1c593160c729f95b9fbf0817ac3cca53d44a876419::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741754564942.avif"));
        let (v1, v2) = 0x2::coin::create_currency<TEST>(arg0, 6, b"TT", b"Test", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<TEST>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST>>(arg0);
    }

    // decompiled from Move bytecode v6
}

