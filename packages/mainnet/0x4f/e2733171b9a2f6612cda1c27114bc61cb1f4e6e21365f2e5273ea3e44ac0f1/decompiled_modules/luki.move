module 0x4fe2733171b9a2f6612cda1c27114bc61cb1f4e6e21365f2e5273ea3e44ac0f1::luki {
    struct LUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUKI>(arg0, 6, b"LUKI", b"Luki - Lofi killer", b"Lofi's killer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia2hcovfht7zoep6rswolgbg4xtlqyritwdfv7rumkxyftgzucg4q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

