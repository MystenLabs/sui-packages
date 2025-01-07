module 0xc6450969d331510b91ffb1dc2a57dbb7b3adde92dbd78c3d655bc3fc5cd0ccb::glb {
    struct GLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLB>(arg0, 9, b"GLB", b"Glebby", b"Cool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bc081e9-6519-4500-807c-e42988363f9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

