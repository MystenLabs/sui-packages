module 0x25f170a3b12a117ac87adf991e88bfcc84aace5842bacd135516954acebe730e::tikdog {
    struct TIKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIKDOG>(arg0, 6, b"TIKDOG", b"TikDog", b"Experience the playful spirit of dogs with the innovative blockchain technology. Join us today!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726876828771_c9c2bce82b74978a3e87079f2ce6e52b_1b153da3eb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIKDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

