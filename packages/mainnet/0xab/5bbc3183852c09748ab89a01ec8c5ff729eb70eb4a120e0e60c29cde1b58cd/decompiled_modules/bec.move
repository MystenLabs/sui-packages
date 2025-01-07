module 0xab5bbc3183852c09748ab89a01ec8c5ff729eb70eb4a120e0e60c29cde1b58cd::bec {
    struct BEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEC>(arg0, 6, b"BEC", b"blue eyed Cat", b"A blue-eyed cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6btmucumawy31_fb2d31e65b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

