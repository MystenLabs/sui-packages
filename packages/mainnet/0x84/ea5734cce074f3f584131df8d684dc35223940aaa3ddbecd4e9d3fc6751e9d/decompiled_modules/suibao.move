module 0x84ea5734cce074f3f584131df8d684dc35223940aaa3ddbecd4e9d3fc6751e9d::suibao {
    struct SUIBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAO>(arg0, 6, b"SUIBAO", b"BAOBAO", b" Hodl Your Dumplings, Baobao is Here!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibao_d77dce409e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

