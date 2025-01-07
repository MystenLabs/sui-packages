module 0x737ee9ea12aafee855bb552ee9a47603f436d6b066730d97f0c79dd8d64c576d::ncv {
    struct NCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NCV>(arg0, 9, b"NCV", b"VC", b"VZV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4ee282f-6e5f-4168-ab09-c9b4e9f1c9b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

