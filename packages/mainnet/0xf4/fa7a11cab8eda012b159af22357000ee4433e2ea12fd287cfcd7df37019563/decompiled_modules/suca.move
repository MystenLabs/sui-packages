module 0xf4fa7a11cab8eda012b159af22357000ee4433e2ea12fd287cfcd7df37019563::suca {
    struct SUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCA>(arg0, 6, b"SUCA", b"Sui Camel", b"Camel tired live on dessert and found Sui water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5511_37512ef43f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

