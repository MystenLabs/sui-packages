module 0x6f74a3e7c4d317216d6ac122ce4216fc1aedede369176996dcf05450476d681d::monkey {
    struct MONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKEY>(arg0, 6, b"MONKEY", b"SUI MONKEY", x"204d4e4b592e2054686520426c756520417374726f6e617574204d6f6e6b6579206f6e2061204d697373696f6e20746f20746865204d6f6f6e21200a47657420726561647920666f7220612077696c642072696465207468726f7567682074686520636f736d6f732077697468204d6f6f6e6b65792c20746865206d656d6520746f6b656e20746861742773206f7574206f66207468697320776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_05_30_07_329a3ea6a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

