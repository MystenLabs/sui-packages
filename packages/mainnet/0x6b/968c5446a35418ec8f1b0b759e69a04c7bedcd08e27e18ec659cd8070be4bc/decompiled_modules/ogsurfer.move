module 0x6b968c5446a35418ec8f1b0b759e69a04c7bedcd08e27e18ec659cd8070be4bc::ogsurfer {
    struct OGSURFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGSURFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGSURFER>(arg0, 6, b"OGSURFER", b"OG Sui Surfer", b"OG Sui Surfer is a vibrant new memecoin designed to ride the waves of the Sui blockchain's thriving ecosystem. Featuring an alien surfer mascot, this token combines fun, community-driven engagement with the high-speed, low-cost transaction capabilities of Sui. Launching exclusively on MovePump, OG Sui Surfer aims to capture the spirit of adventure and innovation, making it a standout addition to the growing collection of Sui-based tokens. *TG Coming Soon ! Updates will be posted on our X profile!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aliensui_overlay_modified_dc5ee2509a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGSURFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGSURFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

