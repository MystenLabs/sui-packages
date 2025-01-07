module 0x5e1dbf5107139dc198e297e7bd2396238d849b102533a79ac62766733b803452::mineralsui {
    struct MINERALSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINERALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINERALSUI>(arg0, 6, b"MineralSui", b"Mineral Water Sui", b"buy it or don't buy it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/damacana_fe132f1087.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINERALSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINERALSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

