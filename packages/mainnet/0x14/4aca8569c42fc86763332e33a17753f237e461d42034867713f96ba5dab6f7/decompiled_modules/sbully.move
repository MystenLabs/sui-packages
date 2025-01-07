module 0x144aca8569c42fc86763332e33a17753f237e461d42034867713f96ba5dab6f7::sbully {
    struct SBULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULLY>(arg0, 6, b"SBULLY", b"SUI BULLY", x"4c4554275320414c4c20474f20544f20544845204d4f4f4e20544f4745544845520a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_VQX_Jc8f_400x400_1_a2af4bc916_843690bfc5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

