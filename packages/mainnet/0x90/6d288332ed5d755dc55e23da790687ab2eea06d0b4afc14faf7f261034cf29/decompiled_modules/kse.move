module 0x906d288332ed5d755dc55e23da790687ab2eea06d0b4afc14faf7f261034cf29::kse {
    struct KSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSE>(arg0, 6, b"KSE", b"KeepSake", b"This is meme of KeepSake marketplace on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1b_cf8ca0f2b4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

