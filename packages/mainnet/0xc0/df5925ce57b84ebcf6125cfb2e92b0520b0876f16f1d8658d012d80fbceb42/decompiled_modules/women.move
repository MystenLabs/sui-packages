module 0xc0df5925ce57b84ebcf6125cfb2e92b0520b0876f16f1d8658d012d80fbceb42::women {
    struct WOMEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOMEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOMEN>(arg0, 6, b"WOMEN", b"Huh ? Women", b"huh $women ? ahahahahaha ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/women_0846bbb193.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOMEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOMEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

