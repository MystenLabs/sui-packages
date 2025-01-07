module 0x5198967d0e7f38b9438b55a2cb78697ca7899a0547b9c38e1cbd5f715c2eba99::prk_ {
    struct PRK_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRK_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRK_>(arg0, 9, b"Prk", b"pRick", b"Rics a pick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"/storage/emulated/0/Download/images.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRK_>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRK_>>(v2, @0xeb2c089aa1487d98a058f1e022a7da5b8ea24700b243eb6f87995c3cacad4d16);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRK_>>(v1);
    }

    // decompiled from Move bytecode v6
}

