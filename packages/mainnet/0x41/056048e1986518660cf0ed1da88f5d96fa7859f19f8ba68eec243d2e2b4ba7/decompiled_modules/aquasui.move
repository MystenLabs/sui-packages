module 0x41056048e1986518660cf0ed1da88f5d96fa7859f19f8ba68eec243d2e2b4ba7::aquasui {
    struct AQUASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUASUI>(arg0, 6, b"AQUASUI", b"WATER", b"SPLASH WATER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/drop_of_water_578897_1920_211a89ce65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

