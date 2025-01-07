module 0xc4161675d01554f324cfedc275f4899bef578879a2176b7ebdf38b1303b271d3::chillpepe {
    struct CHILLPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLPEPE>(arg0, 6, b"CHILLPEPE", b"Chill Pepe Sui", b"Just a blue chill dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chillpepe_56aad52eac.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

