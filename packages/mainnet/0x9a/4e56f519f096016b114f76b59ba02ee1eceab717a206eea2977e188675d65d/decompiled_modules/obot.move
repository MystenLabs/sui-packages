module 0x9a4e56f519f096016b114f76b59ba02ee1eceab717a206eea2977e188675d65d::obot {
    struct OBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBOT>(arg0, 6, b"Obot", b"ordinals bot", b"a ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20230531013539_39424a501b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

