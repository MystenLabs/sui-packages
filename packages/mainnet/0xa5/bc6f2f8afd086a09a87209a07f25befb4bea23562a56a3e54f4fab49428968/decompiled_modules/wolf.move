module 0xa5bc6f2f8afd086a09a87209a07f25befb4bea23562a56a3e54f4fab49428968::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 6, b"WOLF", b"LandWolf", x"466f7267657420706978656c61746564204a5045477320616e6420626f726564207072696d617465732e204c616e64776f6c66206973206865726520746f207368616b65207570207468652063727970746f207363656e65206f6e20535549204e6574776f726b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/landwolf_cb8cdd7275_fabd509f35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

