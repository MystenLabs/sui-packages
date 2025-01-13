module 0x1215edacec8706427bfe6b98c73059a0143782f5f5e352ef2a312e22b0f9fc77::b {
    struct B has drop {
        dummy_field: bool,
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 6, b"B", b"baby", b"Its just a sweet corn on SUI. :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c6dadb7f_7afb_4141_98e8_69cff6983918_ac3b05292f_b93f9190b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B>>(v1);
    }

    // decompiled from Move bytecode v6
}

