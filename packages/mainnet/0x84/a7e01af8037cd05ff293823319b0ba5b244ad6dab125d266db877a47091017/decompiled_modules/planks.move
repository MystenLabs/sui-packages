module 0x84a7e01af8037cd05ff293823319b0ba5b244ad6dab125d266db877a47091017::planks {
    struct PLANKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKS>(arg0, 6, b"PLANKS", b"Plankton on Sui", b"Alone We're Small, Together We're Giants!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logofix_c7dbe84908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

