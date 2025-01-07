module 0xf7f50f966b08fb92482a2122f6fa0bbdf0418c94aabd5109b7960a37c35afeb2::mimi {
    struct MIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMI>(arg0, 6, b"MIMI", b"Mimi", b"MIMI means cute cat and is a beloved name for cats in Chinese-speaking regions.  https://t.me/mimidotlove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i2b_Bzc_QS_400x400_c7909ce157.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

