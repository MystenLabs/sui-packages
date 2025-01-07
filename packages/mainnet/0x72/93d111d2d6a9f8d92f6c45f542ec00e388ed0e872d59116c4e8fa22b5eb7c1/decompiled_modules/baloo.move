module 0x7293d111d2d6a9f8d92f6c45f542ec00e388ed0e872d59116c4e8fa22b5eb7c1::baloo {
    struct BALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOO>(arg0, 6, b"Baloo", b"SuiBaloo", b"Balooooooo the fucking rebellion in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_084606_575_50115753a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

