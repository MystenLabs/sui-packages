module 0x4c12b2535ba84ea51c9a5bb1c8ba98e36299279f6ca25f37fecfee30b1c8028b::stars {
    struct STARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARS>(arg0, 6, b"STARS", b"Star Sui", b"Hello  I'm STAR a starfish from sesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_BUY_5_84e39d38c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

