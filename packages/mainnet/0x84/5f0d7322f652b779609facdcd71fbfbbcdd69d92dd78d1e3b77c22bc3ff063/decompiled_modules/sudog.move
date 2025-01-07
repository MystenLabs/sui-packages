module 0x845f0d7322f652b779609facdcd71fbfbbcdd69d92dd78d1e3b77c22bc3ff063::sudog {
    struct SUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOG>(arg0, 6, b"SuDoG", b"SuiDog", b"Spike frend Tom and Jerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spike_fdffc6067f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

