module 0xe9d11fbe02ea3acf02cacedb9c36cdedd739e004fe5762b038704587d523207a::aiwizzcat {
    struct AIWIZZCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIWIZZCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIWIZZCAT>(arg0, 6, b"AIWIZZCAT", b"AI Wizzard Cat", b"Wizard cat is a magical feline who can speak English and meowish, offering wisdom and guidance to those who seek it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/640_87faa58d61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIWIZZCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIWIZZCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

