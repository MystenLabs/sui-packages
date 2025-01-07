module 0x93e0bd61829177f51ac322b57a66bd850c98959295f65e4e1220ede3b49c071c::soodari {
    struct SOODARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOODARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOODARI>(arg0, 6, b"SOODARI", b"Soodari", b"Introducing SOODARI. This is an adorable otter with soft and white fur.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SOODARI_514585323d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOODARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOODARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

