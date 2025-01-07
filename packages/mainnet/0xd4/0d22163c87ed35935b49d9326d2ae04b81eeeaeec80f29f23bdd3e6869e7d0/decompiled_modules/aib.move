module 0xd40d22163c87ed35935b49d9326d2ae04b81eeeaeec80f29f23bdd3e6869e7d0::aib {
    struct AIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIB>(arg0, 6, b"AIB", b"AI  BrotherOS", b"Uncensored AI On SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2343242_2b92d9f6f7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

