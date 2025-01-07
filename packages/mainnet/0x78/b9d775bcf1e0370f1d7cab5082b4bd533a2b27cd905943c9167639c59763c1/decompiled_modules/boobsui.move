module 0x78b9d775bcf1e0370f1d7cab5082b4bd533a2b27cd905943c9167639c59763c1::boobsui {
    struct BOOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSUI>(arg0, 6, b"BooBsui", b"Boobsui", b"Hii I'm boobsui a little horny memecoin with squishy, soft, big bouncy eyes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000166598_af371f5ecb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

