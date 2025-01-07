module 0xee3d48b13d7d5055a73fa3148f1dda4c16bce47410a9fc8ed360f87cbf904020::pussy {
    struct PUSSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSY>(arg0, 9, b"PUSSY", b"PUSSY CAT", x"507572656c792064656469636174656420746f2074686520676c6f7279206f6620612070757373792063617420f09f8c9a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2aca91f4-c1ed-494c-9bea-a59fc163342b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUSSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

