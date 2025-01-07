module 0xce85ec8fecf7888977237085b224e11a1b9025b6e2c9997746129f2089809c5e::pwengpweng {
    struct PWENGPWENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENGPWENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENGPWENG>(arg0, 6, b"PWENGPWENG", b"Pweng", b"Jus a wittle Pweng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pweng_62c772dc9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENGPWENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENGPWENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

