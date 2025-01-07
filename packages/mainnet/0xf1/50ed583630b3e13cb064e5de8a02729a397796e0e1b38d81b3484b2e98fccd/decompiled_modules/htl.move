module 0xf150ed583630b3e13cb064e5de8a02729a397796e0e1b38d81b3484b2e98fccd::htl {
    struct HTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTL>(arg0, 9, b"HTL", b"Hutsul", b"Hutsuls  are an ethnographic group of Ukrainians who live in the Carpathians and who, according to one version, are descendants of the most ancient tribe of chronicled Ulychi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/306ffef6-953b-4900-a1ce-62b629dfabea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HTL>>(v1);
    }

    // decompiled from Move bytecode v6
}

