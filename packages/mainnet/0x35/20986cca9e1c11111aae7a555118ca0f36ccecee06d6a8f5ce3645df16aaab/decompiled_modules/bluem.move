module 0x3520986cca9e1c11111aae7a555118ca0f36ccecee06d6a8f5ce3645df16aaab::bluem {
    struct BLUEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEM>(arg0, 6, b"BLUEM", b"Bluem", b"The Bluem Kitty - is a large cat breed originating from Merkurius", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000160128_8ee7cd705f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

