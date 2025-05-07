module 0x55686d63a4f43202d958da1db65635b02ae4ab6ec8dab91024b862ec91cc203b::mywal {
    struct MYWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYWAL>(arg0, 6, b"MyWAL", b"MyWal", b"hi there", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WAL_da946e689f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

