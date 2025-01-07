module 0x222955a7d4a783aea42f7a9c151dd28dac5bd2e75bdebda057ec45be615edd8b::cattype {
    struct CATTYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATTYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATTYPE>(arg0, 6, b"CATTYPE", b"Cattype on Sui", b"im ready to write some code. movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfsdfsfsf_c209aa42b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATTYPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATTYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

