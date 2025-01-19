module 0x90053814aa08be3eac26df915f38acab064a802ceee6dfa7f4aed0ba139cf21b::pain {
    struct PAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAIN>(arg0, 6, b"PAIN", b"Pain guy", b"He is a pain guy! Suffering from pain in whole life time ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014171_1786026dcb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

