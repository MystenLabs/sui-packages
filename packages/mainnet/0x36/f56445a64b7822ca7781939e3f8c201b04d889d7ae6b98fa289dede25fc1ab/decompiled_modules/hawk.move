module 0x36f56445a64b7822ca7781939e3f8c201b04d889d7ae6b98fa289dede25fc1ab::hawk {
    struct HAWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAWK>(arg0, 1, b"HAWK", b"Hawk Tuah", b"HT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAWK>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAWK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

