module 0x4bf7ef5318d49f7a828d23c0c9fc12dae230f713c2d319869a4c7bf1253363a::suimaid {
    struct SUIMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAID>(arg0, 6, b"SUIMAID", b"SUI's Beautiful MERMAID", b"SUIMAID is the enchanting mermaid token gliding through the Sui . Explore hidden treasures and make waves in the Sui sea with SUIMAID's mystical charm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIMAID_1e17b075eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

