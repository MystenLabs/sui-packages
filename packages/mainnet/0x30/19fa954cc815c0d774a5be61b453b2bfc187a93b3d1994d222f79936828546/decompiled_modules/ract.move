module 0x3019fa954cc815c0d774a5be61b453b2bfc187a93b3d1994d222f79936828546::ract {
    struct RACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACT>(arg0, 6, b"RACT", b"SUI RACT", b"Meet the RACT, the cat with attutude. Inspired by legendary meme characters Matt Furie character RACT got its own twistthink of a mischievous, cunning cat thats always one step ahead.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GLU_Jnm7_XEAA_2ogu_copy_95a8188fbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

