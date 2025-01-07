module 0x2be80c9eeffa139db234f381ec43bb0170ee5dd6c1435f536e8834eddad92296::ns {
    struct NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NS>(arg0, 6, b"NS", b"NEED SPACE", b"An exploration from a mysterious space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1562_b4c48b5358.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NS>>(v1);
    }

    // decompiled from Move bytecode v6
}

