module 0x3dc63431653f783202b461f050c953aa4bf7557337380c18e2697698734b2a6d::pj {
    struct PJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJ>(arg0, 6, b"PJ", b"PumpUpTheJam", b"Lets PUMP! Lets JAM! This is PumpUpTheJam!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_d518924710.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

