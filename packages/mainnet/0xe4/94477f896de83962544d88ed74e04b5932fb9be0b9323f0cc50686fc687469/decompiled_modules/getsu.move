module 0xe494477f896de83962544d88ed74e04b5932fb9be0b9323f0cc50686fc687469::getsu {
    struct GETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GETSU>(arg0, 6, b"GETSU", b"SUIGETSU", b"Getsu in sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241008_202704_847_dcd4c0cfeb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

