module 0x810295446e7e078abf875d351f7f0d3b6bed493dd3cd41ff0731b889a851c78e::aquaman {
    struct AQUAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAMAN>(arg0, 6, b"AQUAMAN", b"AQUAMAN SUI", b"AQUAMAN, in charge of all MEME in the SUI world, KING in the sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43434334_e8f040eee8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

