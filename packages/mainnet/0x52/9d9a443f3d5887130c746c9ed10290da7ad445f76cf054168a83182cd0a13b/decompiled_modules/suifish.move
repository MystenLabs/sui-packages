module 0x529d9a443f3d5887130c746c9ed10290da7ad445f76cf054168a83182cd0a13b::suifish {
    struct SUIFISH has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SMPL", b"Simple Token", b"Simple Token showcases", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://x.com/97899343-75e3-4a0e-b6b2-9263b416835e")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIFISH>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIFISH>(&mut v0, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFISH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

