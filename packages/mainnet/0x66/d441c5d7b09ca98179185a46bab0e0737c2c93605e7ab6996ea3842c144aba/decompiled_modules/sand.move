module 0x66d441c5d7b09ca98179185a46bab0e0737c2c93605e7ab6996ea3842c144aba::sand {
    struct SAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAND>(arg0, 6, b"SAND", b"Sandy Official on SUI", b"Sandy, The Cutest Mascot on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_3_40c768e90b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

