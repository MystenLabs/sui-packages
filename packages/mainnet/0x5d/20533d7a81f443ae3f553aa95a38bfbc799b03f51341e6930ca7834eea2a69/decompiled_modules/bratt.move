module 0x5d20533d7a81f443ae3f553aa95a38bfbc799b03f51341e6930ca7834eea2a69::bratt {
    struct BRATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRATT>(arg0, 6, b"BRATT", b"Bratt Monster", b"Official First Bratt On Sui .Join us: https://www.brattsui.monster", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/top_3333_89d2324a15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

