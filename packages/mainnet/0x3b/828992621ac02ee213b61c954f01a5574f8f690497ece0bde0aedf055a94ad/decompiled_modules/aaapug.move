module 0x3b828992621ac02ee213b61c954f01a5574f8f690497ece0bde0aedf055a94ad::aaapug {
    struct AAAPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPUG>(arg0, 6, b"aaaPug", b"aaaPug Sui", b"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/head_shot_cute_pug_puppy_260nw_262600109_c99569450b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

