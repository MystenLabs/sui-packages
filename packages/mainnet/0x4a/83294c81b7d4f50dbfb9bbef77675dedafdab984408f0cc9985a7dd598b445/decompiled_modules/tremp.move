module 0x4a83294c81b7d4f50dbfb9bbef77675dedafdab984408f0cc9985a7dd598b445::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"Tremp", b"Meme Tremp", b"Shut up,boden.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20240611_220131_8ef0b72761.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

