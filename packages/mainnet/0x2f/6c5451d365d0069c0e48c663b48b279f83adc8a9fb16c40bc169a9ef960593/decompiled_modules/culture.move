module 0x2f6c5451d365d0069c0e48c663b48b279f83adc8a9fb16c40bc169a9ef960593::culture {
    struct CULTURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTURE>(arg0, 6, b"Culture", b"Men of Sui Culture", b"Ah, I see you're a man of Sui culture as well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_W_Xna_Xnqeq_F5_Nxyjh_Ros_Vqs4j_PM_8_XXEV_Jb_Mmk_D69pump_9f852bcd2d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULTURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULTURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

