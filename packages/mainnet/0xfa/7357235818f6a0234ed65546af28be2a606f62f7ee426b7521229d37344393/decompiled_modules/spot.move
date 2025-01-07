module 0xfa7357235818f6a0234ed65546af28be2a606f62f7ee426b7521229d37344393::spot {
    struct SPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOT>(arg0, 6, b"SPOT", b"SPOT AI", b"SPOT AI is a groundbreaking Buybot developed for the SUI network, designed to enhance and streamline your trading experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1884_4f6e347f24.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

