module 0x335b22bbbf3986b97764e91170fcfd46e73c2f0da21702be02cd6dcd8a67543b::pnutai {
    struct PNUTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTAI>(arg0, 6, b"PNUTAI", b"Peanut the Squirrel Ai", b"Meet $PNUTAI, Peanut the Squirrel faced a tragic end, wrongfully taken and euthanized by the NYDEC. But legends never truly die. Now, PNut lives on Sui, reborn on the Sui blockchain, cloaked in codes and digital green. A symbol of resilience and rebellion, $PNUTAI fights back, carving out a new legacy in the decentralized world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_4_890ca195fd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

