module 0xc857b90de0dede3d1959c8c9d7c43361b28a61b9fec526e31006e39b64532030::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"Fox", b"foxsui", b"im a 1st fox on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731165371367.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

