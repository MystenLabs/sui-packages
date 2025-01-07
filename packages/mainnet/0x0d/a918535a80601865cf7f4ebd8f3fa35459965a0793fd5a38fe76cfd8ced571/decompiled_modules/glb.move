module 0xda918535a80601865cf7f4ebd8f3fa35459965a0793fd5a38fe76cfd8ced571::glb {
    struct GLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLB>(arg0, 9, b"GLB", b"GLOBAL", b"GLOBAL is a cutting-edge cryptocurrency designed to facilitate seamless cross-border transactions and foster international collaboration. With a focus on security, speed, and scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/418bd8cc-0e4d-47e5-8ca6-0a0dda98bba9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

