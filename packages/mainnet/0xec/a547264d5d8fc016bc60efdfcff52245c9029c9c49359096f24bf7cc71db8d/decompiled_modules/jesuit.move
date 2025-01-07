module 0xeca547264d5d8fc016bc60efdfcff52245c9029c9c49359096f24bf7cc71db8d::jesuit {
    struct JESUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIT>(arg0, 6, b"JeSUIt", b"JeSUIts", b"jeSUIts at SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/700x450_Pilot_14741_jpg_e14fd19a95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

