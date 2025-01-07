module 0xfbfdc6eefd3ae3efcfb63b521402f9d49179e31d3efc9bb83bf64bae338cb0f5::scr {
    struct SCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCR>(arg0, 6, b"SCR", b"Scroll", b"The leading zero-knowledge rollup.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fq5_O0_Le_N_400x400_03d30ab43e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

