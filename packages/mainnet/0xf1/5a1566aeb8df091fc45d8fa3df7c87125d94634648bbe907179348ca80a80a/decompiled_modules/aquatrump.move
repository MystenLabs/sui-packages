module 0xf15a1566aeb8df091fc45d8fa3df7c87125d94634648bbe907179348ca80a80a::aquatrump {
    struct AQUATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUATRUMP>(arg0, 6, b"AQUATRUMP", b"AQUA TRUMP", b"AQUATRUMP celebrates his victory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Turbotext_AI_Image_4574350_0b29186759.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

