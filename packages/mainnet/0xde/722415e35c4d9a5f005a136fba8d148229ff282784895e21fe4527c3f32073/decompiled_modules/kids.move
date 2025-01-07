module 0xde722415e35c4d9a5f005a136fba8d148229ff282784895e21fe4527c3f32073::kids {
    struct KIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDS>(arg0, 9, b"KIDS", b"Kid", b"FOR THE CULTURE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a72ebfda-5232-4b64-9364-7b668b60bfce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

