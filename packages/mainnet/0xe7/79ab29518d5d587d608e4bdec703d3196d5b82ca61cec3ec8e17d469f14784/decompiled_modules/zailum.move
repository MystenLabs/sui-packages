module 0xe779ab29518d5d587d608e4bdec703d3196d5b82ca61cec3ec8e17d469f14784::zailum {
    struct ZAILUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAILUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAILUM>(arg0, 6, b"ZAiLUM", b"Sui ZAiLUM", b"ZAiLUM- THE WORLDS FIRST COMPLETE Ai VIRTUAL ASSISTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029034_ab9c499ee5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAILUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAILUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

