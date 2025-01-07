module 0x1066f79cf29ecb61bca9c60141978fd1c470caa8089bbfa7e786b7553f34522d::pickle {
    struct PICKLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLE>(arg0, 6, b"Pickle", b"Pickle of Sui", x"54686520667269656e646c69657374207069636b6c65206f66205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pickle_73d7171db6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

