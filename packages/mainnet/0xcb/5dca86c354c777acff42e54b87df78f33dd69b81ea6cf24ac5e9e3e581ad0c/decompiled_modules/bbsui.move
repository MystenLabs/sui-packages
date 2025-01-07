module 0xcb5dca86c354c777acff42e54b87df78f33dd69b81ea6cf24ac5e9e3e581ad0c::bbsui {
    struct BBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUI>(arg0, 6, b"BBSUI", b"BaBy Water", b"cute water drops on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/321_1d649c372c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

