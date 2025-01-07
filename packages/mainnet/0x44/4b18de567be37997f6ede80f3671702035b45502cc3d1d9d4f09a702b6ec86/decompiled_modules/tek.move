module 0x444b18de567be37997f6ede80f3671702035b45502cc3d1d9d4f09a702b6ec86::tek {
    struct TEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEK>(arg0, 6, b"Tek", b"iaejo", b"w8herooi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/T_Rump_X_needs_editing_444f20fb94.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

