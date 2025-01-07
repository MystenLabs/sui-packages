module 0x423308c3441268ddb71c2f21a63e8a5d3513305daf7e901593acae2dd177c673::rkamala {
    struct RKAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKAMALA>(arg0, 6, b"rKamala", b"Retardio Kamala", b"Kamala has gone full retardio!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_03_18_34_08bad148e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

