module 0x63fc8b03c2de56154c333fc4d584edcbeff7db21b423164fd5a4b40df7b9ae9::niki {
    struct NIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIKI>(arg0, 6, b"NIKI", b"Nikiozeri", b"This is $NIKI on a normal day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049049_1237787609.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

