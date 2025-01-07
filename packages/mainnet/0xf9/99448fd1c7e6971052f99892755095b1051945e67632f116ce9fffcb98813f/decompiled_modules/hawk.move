module 0xf999448fd1c7e6971052f99892755095b1051945e67632f116ce9fffcb98813f::hawk {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 6, b"HAWK", b"HawkSuiCTO", b"Hawk sui is the first and only CTO hawk tuah meme coin on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241008_084724_4885451638.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

