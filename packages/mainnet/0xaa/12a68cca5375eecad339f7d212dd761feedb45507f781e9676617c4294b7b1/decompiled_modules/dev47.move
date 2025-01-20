module 0xaa12a68cca5375eecad339f7d212dd761feedb45507f781e9676617c4294b7b1::dev47 {
    struct DEV47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV47>(arg0, 6, b"DEV47", b"47TH DEV OF AMERICA", b"DEV47 - The 47th DEV of the USA! Huge memes, big dreams, the best coinbelieve me. Were making crypto great again, and its gonna be YUGE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_030622_813_2b61a4d313.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEV47>>(v1);
    }

    // decompiled from Move bytecode v6
}

