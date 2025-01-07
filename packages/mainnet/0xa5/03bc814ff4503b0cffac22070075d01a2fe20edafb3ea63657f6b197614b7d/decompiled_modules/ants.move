module 0xa503bc814ff4503b0cffac22070075d01a2fe20edafb3ea63657f6b197614b7d::ants {
    struct ANTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTS>(arg0, 6, b"ANTS", b"Ants Sui", b"AntSui first meme ant on movepump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004663_2f17f5f5c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

