module 0x845e65e0f1ed22a4d19057eb3e323412d3ec2829518b67e417b2257e0017efe::nauts {
    struct NAUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUTS>(arg0, 6, b"NAUTS", b"Nauts Coin", b"$NAUTS everywhere, charting the infinite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050416_f39b26ae3e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

