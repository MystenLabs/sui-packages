module 0x5399a68952736bc601832005449814d7f5313b7cd7a29655e5eca9f2d3220daa::trumpwin {
    struct TRUMPWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWIN>(arg0, 6, b"TRUMPWIN", b"TRUMP WIN", b"Donald Trump or Kamala Harris ??????", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/licensed_image_943afa8527.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPWIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

