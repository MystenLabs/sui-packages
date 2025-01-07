module 0x760820bf265f78d0c110b00f0b35ac931b1f247051308d8b0e69b76c17e08102::suillama {
    struct SUILLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLAMA>(arg0, 6, b"SUILLAMA", b"SUI LLAMA", b"SUI NETWORKS first LLAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o4_AT_1z4_L_400x400_49818bbc5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

