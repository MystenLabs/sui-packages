module 0x7d79c080a7fecbce6a3fc975e9b1ce46d02513e8fee7176200b125ce799087ec::rugpull {
    struct RUGPULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPULL>(arg0, 6, b"RUGPULL", b"DONT BUY", b"Are you serious?!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I_I_I_I_I_I_I_I_I_I_I_I_I_I_I_28_1ac42ec53a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

