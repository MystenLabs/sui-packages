module 0xab315f09a45181e59081ea2a4fc8e0d054d7e832f68f8d16c9216de82e23e784::pufecat {
    struct PUFECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFECAT>(arg0, 6, b"PUFECAT", b"PUFFER EATING CARROT", b"HAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/puffer_6618eb93c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

