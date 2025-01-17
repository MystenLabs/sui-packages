module 0x38230271c18f5a2f834006f8d644b441a11f72977e735af799aaf42ea4327c31::sunny {
    struct SUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNNY>(arg0, 6, b"SUNNY", b"Sunny memecoin", b"Introducing Sunny  a radiant yellow beacon designed to brighten the entire SUI universe!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_220838_769_4cc3e81cf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

