module 0x4ef3746f9d86475d21181720383fc64344b40369ed87198b9e21951b261336b::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"Pika", b"PIKASUI", b"Pikasui, the king of cryptocurrency on Sui, rules with wisdom. His sparkling aura guides investors, promoting innovation and collaboration. Under his reign, Sui thrives, inspiring everyone to believe in their dreams and build a bright future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013501_d8368e4c96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

