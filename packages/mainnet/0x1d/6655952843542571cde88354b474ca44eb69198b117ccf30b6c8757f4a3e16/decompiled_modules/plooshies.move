module 0x1d6655952843542571cde88354b474ca44eb69198b117ccf30b6c8757f4a3e16::plooshies {
    struct PLOOSHIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOSHIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOSHIES>(arg0, 6, b"PLOOSHIES", b"The Plooshies", b"Building a global Love-Brand around both digital and physical products and centered on community engagement, interactive storytelling, and gaming experiences", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hl_VZ_2vs_Z_400x400_1a797cf334.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOSHIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOSHIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

