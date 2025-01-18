module 0x3ab1fcfb54da3cd93e2d3a218c1e0e4c5c577eedbecde8edd707f8d90068f00d::ru {
    struct RU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RU>(arg0, 9, b"RU", b"RUB", x"d0a6d0b8d184d180d0bed0b2d0bed0b920d180d183d0b1d0bbd18cc2a0e28094c2a0d184d0bed180d0bcd0b020d0bdd0b0d186d0b8d0bed0bdd0b0d0bbd18cd0bdd0bed0b920d0b2d0b0d0bbd18ed182d18b2c20d0bad0bed182d0bed180d183d18e20d0b2d18bd0bfd183d181d0bad0b0d0b5d18220d091d0b0d0bdd0ba20d0a0d0bed181d181d0b8d0b820d0b220d0bad0b0d187d0b5d181d182d0b2d0b520d0b4d0bed0bfd0bed0bbd0bdd0b5d0bdd0b8d18f20d0ba20d183d0b6d0b520d181d183d189d0b5d181d182d0b2d183d18ed189d0b8d0bc2e20d0add182d0be20d183d0bdd0b8d0bad0b0d0bbd18cd0bdd18bd0b920d18dd0bbd0b5d0bad182d180d0bed0bdd0bdd18bd0b920d0bad0bed0b420e2809420d182d0bed0bad0b5d0bd2ec2a0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/222cf086-8215-4ee4-9a8a-f5041288bb66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RU>>(v1);
    }

    // decompiled from Move bytecode v6
}

