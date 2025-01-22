module 0x2af990f519a45a547580ffae75c5a623bd81644f61c4bc14d783e648b90d7d62::grump {
    struct GRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRUMP>(arg0, 6, b"GRUMP", b"Grump Official Meme on SUI", b"When Trumps having a bad day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6091192155163967599_y_dac85d3350.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

