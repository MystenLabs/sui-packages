module 0x7595526206ffc3a5b7294b18135b6e9b450852746b62e42738d528ab2a15c7e3::tch {
    struct TCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCH>(arg0, 9, b"TCH", b"Tech", b"Tech is an innovative cryptocurrency designed to drive advancements in technology and startups. By connecting investors with emerging tech projects, Tech fosters growth and innovation in the digital landscape, powering the future of tech entrepreneurship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/40851dd8-b8e3-4ba9-a2cb-f06ba59b62d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

