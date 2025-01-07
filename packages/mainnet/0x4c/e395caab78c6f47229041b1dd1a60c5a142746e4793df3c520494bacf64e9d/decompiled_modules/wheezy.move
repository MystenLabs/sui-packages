module 0x4ce395caab78c6f47229041b1dd1a60c5a142746e4793df3c520494bacf64e9d::wheezy {
    struct WHEEZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHEEZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHEEZY>(arg0, 6, b"Wheezy", b"wheezy", b"Your favorite Toy Penguin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sdfgsdfgsdfgsdgsdgfsdfgsdfg_34e202959e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHEEZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHEEZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

