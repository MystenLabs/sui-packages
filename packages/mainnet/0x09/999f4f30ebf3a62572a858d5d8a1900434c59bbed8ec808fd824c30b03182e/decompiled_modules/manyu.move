module 0x9999f4f30ebf3a62572a858d5d8a1900434c59bbed8ec808fd824c30b03182e::manyu {
    struct MANYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANYU>(arg0, 6, b"Manyu", b"Manyu DOG", b"manyu MANYU Manyu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ssss_1955bd4440.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

