module 0x919231d2985632972b1790c8969ff131f5df07cdf41fe38920dc970c0bd4ceb2::aaaaaaaaaaaaaaaaaaaaaaaaaaaaa {
    struct AAAAAAAAAAAAAAAAAAAAAAAAAAAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAAAAAAAAAAAAAAAAAAAAAAAAAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAAAAAAAAAAAAAAAAAAAAAAAAAAA>(arg0, 6, b"Aaaaaaaaaaaaaaaaaaaaaaaaaaaaa", b"Aaadoge", b"Aaaaaaaaaaaaaaaaaaafirstnotgmetaonsuiiiiiaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/C6551_B53_D608_4592_8_E03_216536_F8_C607_ab08a71d9e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAAAAAAAAAAAAAAAAAAAAAAAAAAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAAAAAAAAAAAAAAAAAAAAAAAAAAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

