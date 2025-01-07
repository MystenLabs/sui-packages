module 0x2c2643549a5e9499186d8a469bd330a44dd052c602d23495396eb62f22cfb9b1::movebitch {
    struct MOVEBITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEBITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEBITCH>(arg0, 6, b"MOVEBITCH", b"Move bitch", b"movington", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny_31472a8716.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEBITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEBITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

