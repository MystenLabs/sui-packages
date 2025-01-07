module 0x3a7e1d738b9c555901c75fe051effc7a6917bde7018bac47deac67a0faba9c5f::tyson {
    struct TYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSON>(arg0, 6, b"Tyson", b"Mike Tyson", b"Everyone has a plan 'till they get punched in the mouth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_Getty_Images_1762174831_2ea01714ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

