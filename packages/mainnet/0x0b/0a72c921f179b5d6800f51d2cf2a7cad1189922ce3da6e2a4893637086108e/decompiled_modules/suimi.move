module 0xb0a72c921f179b5d6800f51d2cf2a7cad1189922ce3da6e2a4893637086108e::suimi {
    struct SUIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMI>(arg0, 6, b"SUIMI", b"SUIMI CAT", b"SUIMI means cute cat and is a beloved name for cats in Chinese-speaking regions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i2b_Bzc_QS_400x400_582f3239b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

