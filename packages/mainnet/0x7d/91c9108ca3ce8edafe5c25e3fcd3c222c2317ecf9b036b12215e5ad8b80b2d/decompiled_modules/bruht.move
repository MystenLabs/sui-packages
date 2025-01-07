module 0x7d91c9108ca3ce8edafe5c25e3fcd3c222c2317ecf9b036b12215e5ad8b80b2d::bruht {
    struct BRUHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUHT>(arg0, 6, b"BRUHT", b"BRUH ON SUI", b"Bruh. Bruh. Bruh. Bruh. Bruh. Bruh. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qd_MS_6_SVL_400x400_c88d4f0c20.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

