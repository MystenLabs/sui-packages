module 0xf869dee8b4acf82085865ce140ac2a29302f23d8303df491bfcd6d0668988374::tete {
    struct TETE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETE>(arg0, 6, b"TETE", b"Tete token", b"tETE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ad_special_price_5833aa6348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETE>>(v1);
    }

    // decompiled from Move bytecode v6
}

