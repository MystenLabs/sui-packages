module 0xaa6cb8edd73e31f5f8c15ac0903cdc755e685492c78cae105c821d3f1fe4c173::ppcat {
    struct PPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPCAT>(arg0, 9, b"PPCAT", b"PEPEEES", b"PAOL CAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4e08425-37a8-4e8a-b61d-b12e1c1945f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

