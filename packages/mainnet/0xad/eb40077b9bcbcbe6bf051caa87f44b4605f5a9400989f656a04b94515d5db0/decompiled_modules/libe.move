module 0xadeb40077b9bcbcbe6bf051caa87f44b4605f5a9400989f656a04b94515d5db0::libe {
    struct LIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIBE>(arg0, 6, b"LIBE", b"SUI LIBERTE", b"SUI LIBERTE SUI LIBERTE SUI LIBERTE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/293705926_400511782143983_1687725560324363585_n_8163a1a6a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

