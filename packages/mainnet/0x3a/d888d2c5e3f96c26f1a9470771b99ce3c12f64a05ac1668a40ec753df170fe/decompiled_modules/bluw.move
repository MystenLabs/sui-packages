module 0x3ad888d2c5e3f96c26f1a9470771b99ce3c12f64a05ac1668a40ec753df170fe::bluw {
    struct BLUW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUW>(arg0, 6, b"BLUW", b"Bluw on Sui", b"Cutest Vibes, Diamond Hands, and Lambo Dreams. Join the BLUWiverse!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055274_f790bfd708.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUW>>(v1);
    }

    // decompiled from Move bytecode v6
}

