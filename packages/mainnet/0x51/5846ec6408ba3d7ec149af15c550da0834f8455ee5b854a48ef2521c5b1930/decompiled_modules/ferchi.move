module 0x515846ec6408ba3d7ec149af15c550da0834f8455ee5b854a48ef2521c5b1930::ferchi {
    struct FERCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERCHI>(arg0, 6, b"Ferchi", b"FerchiDog", b"It's a pet dick sucker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_4990149272762690641_y_824dc0572a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FERCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

