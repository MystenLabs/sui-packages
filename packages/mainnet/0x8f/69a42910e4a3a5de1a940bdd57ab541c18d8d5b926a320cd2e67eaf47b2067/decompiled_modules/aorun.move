module 0x8f69a42910e4a3a5de1a940bdd57ab541c18d8d5b926a320cd2e67eaf47b2067::aorun {
    struct AORUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AORUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AORUN>(arg0, 6, b"AORUN", b"AORUNGUGU", b"Ao Run is a key antagonist in the animated film Nezha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wechat_IMG_175_0a9d89ee7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AORUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AORUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

