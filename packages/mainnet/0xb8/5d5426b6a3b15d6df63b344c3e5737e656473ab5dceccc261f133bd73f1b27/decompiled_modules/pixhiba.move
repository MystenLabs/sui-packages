module 0xb85d5426b6a3b15d6df63b344c3e5737e656473ab5dceccc261f133bd73f1b27::pixhiba {
    struct PIXHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXHIBA>(arg0, 6, b"PIXHIBA", b"Sui Pixel Shiba", b"$PIXHIBA are ready to take over the Sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixhiba_08bdb3f619.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIXHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

