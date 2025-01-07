module 0x4e56a20e1b9e82d28f963d6162d3e98c665697c22abecd9a9f544e3d44a7aaa8::boodeng {
    struct BOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOODENG>(arg0, 6, b"Boodeng", b"BoodengSui", b"Thw new booo meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000990_1251dfdc11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOODENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

