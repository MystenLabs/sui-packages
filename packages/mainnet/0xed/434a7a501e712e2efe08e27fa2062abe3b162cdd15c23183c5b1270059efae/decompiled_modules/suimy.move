module 0xed434a7a501e712e2efe08e27fa2062abe3b162cdd15c23183c5b1270059efae::suimy {
    struct SUIMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMY>(arg0, 6, b"SUIMY", b"SUI COMMUNITY", b"This Meme Project On Sui With 100% Community Driven , Lets Mooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2mtr5g_9a164132db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

