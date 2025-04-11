module 0x305d48a2c6b68e6b61ff5bbb37ecc3e48bcb5af43b3731fc59fdf1f052cef14f::ovi {
    struct OVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVI>(arg0, 6, b"OVI", b"OVECHKIN", x"244f564543484b494e20e2809420d09cd0b5d0bc2dd182d0bed0bad0b5d0bd20d0b2d0b5d0bbd0b8d0bad0bed0b3d0be20d181d0bdd0b0d0b9d0bfd0b5d180d0b00a0a244f564543484b494e20e2809420d18dd182d0be20d0bdd0b520d0bfd180d0bed181d182d0be20d182d0bed0bad0b5d0bd2e20d0add182d0be20d186d0b8d184d180d0bed0b2d0bed0b520d0b2d0bed0bfd0bbd0bed189d0b5d0bdd0b8d0b520d0bbd0b5d0b3d0b5d0bdd0b4d18b2e20d0a1d0b8d0bcd0b2d0bed0bb20d0b3d0bed0bbd0bed0b22c20d0b1d0bed180d0bed0b4d18b2c20d188d0b0d0b9d0b120d0b820d0b1d0b5d0b7d183d0bcd0bdd0bed0b920d0bbd18ed0b1d0b2d0b820d0ba20d185d0bed0bad0bad0b5d18e2e20d09cd0b5d0bc2dd182d0bed0bad0b5d0bd2c20d0b2d0b4d0bed185d0bdd0bed0b2d0bbd191d0bdd0bdd18bd0b920d0bed0b4d0bdd0b8d0bc20d0b8d0b720d0b2d0b5d0bbd0b8d187d0b0d0b9d188d0b8d18520d0b8d0b3d180d0bed0bad0bed0b220d0b220d0b8d181d182d0bed180d0b8d0b820d09dd0a5d09b20e2809420d090d0bbd0b5d0bad181d0b0d0bdd0b4d180d0bed0bc20d09ed0b2d0b5d187d0bad0b8d0bdd18b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1744374811078.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

