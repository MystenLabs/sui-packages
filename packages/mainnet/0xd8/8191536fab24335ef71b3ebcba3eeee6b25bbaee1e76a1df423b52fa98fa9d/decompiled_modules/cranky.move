module 0xd88191536fab24335ef71b3ebcba3eeee6b25bbaee1e76a1df423b52fa98fa9d::cranky {
    struct CRANKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRANKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRANKY>(arg0, 6, b"CRANKY", b"The most cranky", b"Hi, Im Cranky. Everything annoys me, and Im not afraid to say it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048494_6597f901b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRANKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRANKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

