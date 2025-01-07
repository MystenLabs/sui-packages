module 0x3d865af83fc9562fe727d33335cb6ddbac3cbfc727520210be7cd5165e057879::dcat {
    struct DCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCAT>(arg0, 6, b"DCAT", b"DumbCat", b"Dumb Money Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3848_ef60157884.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

