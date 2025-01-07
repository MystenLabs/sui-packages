module 0xa90f9ffcf0be029c031053bde8e354d45c5e1c9784a13b168590b0019b9b1e49::sugetsu {
    struct SUGETSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGETSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGETSU>(arg0, 6, b"SUGETSU", b"SUIGETSU TOKEN", b"SUIGETSU, an anime token on SUI blockchain. SUI means water in Chinese and Suigetsu is a water based justu user from the Naruto anime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suigetsu_b0009c86aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGETSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGETSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

