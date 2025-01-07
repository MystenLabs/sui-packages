module 0x4e3094d95692eed822c60f2cb7aed8c8cbbe86952fede026ac1b4162b5859125::shuito {
    struct SHUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUITO>(arg0, 6, b"SHUITO", b"Shuito", b"Shuito The Ninja Cat! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_02_at_9_22_50_PM_ab08532961.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

