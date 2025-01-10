module 0xff20abf92c356df0723edd18b404b3bcf6cdce3c2c2a435d47480f73662445cd::cbs {
    struct CBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBS>(arg0, 6, b"CBS", b"ChillBird on sui", b"Welcome to the world of ChillBird! Join us in exploring the community, ChillBird group where you can share your passion for crypto and connect with new friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_10_10_57_13_4318565685.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

