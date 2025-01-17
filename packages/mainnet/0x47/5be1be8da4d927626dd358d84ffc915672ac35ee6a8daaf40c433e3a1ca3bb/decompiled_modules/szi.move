module 0x475be1be8da4d927626dd358d84ffc915672ac35ee6a8daaf40c433e3a1ca3bb::szi {
    struct SZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZI>(arg0, 6, b"SZI", b"Suizi AI", x"436c6f6e6520796f7572206661766f7269746520736f6e677320616e6420637573746f6d69736520746865206c7972696373202d20706f77657265642062792024535a492e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Copy_of_0xe3360ed65e5e6c1d584647d02333aead5942357502574654c266d83cf8c455a0towel_TOWEL_200_x_200_px_500_x_500_px_6_d89e507936.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

