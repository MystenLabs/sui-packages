module 0xf053671b9dc1f0fe4e63c59da965a84b02d7b3d1e45ac6ab1b805b2e87de5e2a::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Ik804", b"Boss ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45806c7d-fb17-4446-9554-446857d65593.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
    }

    // decompiled from Move bytecode v6
}

