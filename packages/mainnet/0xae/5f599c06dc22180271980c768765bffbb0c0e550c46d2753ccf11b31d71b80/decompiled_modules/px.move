module 0xae5f599c06dc22180271980c768765bffbb0c0e550c46d2753ccf11b31d71b80::px {
    struct PX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PX>(arg0, 6, b"Px", b"Phoenix", b"It is a community-backed currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000279_2b722c36c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PX>>(v1);
    }

    // decompiled from Move bytecode v6
}

