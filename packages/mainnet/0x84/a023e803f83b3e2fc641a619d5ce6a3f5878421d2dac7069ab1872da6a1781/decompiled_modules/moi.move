module 0x84a023e803f83b3e2fc641a619d5ce6a3f5878421d2dac7069ab1872da6a1781::moi {
    struct MOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOI>(arg0, 6, b"MOI", b"MOI SUI", b"$MOI -  when the MOI are in danger, She leaps into action. Sometimes tripping, sometimes flying. But always saving the day in the end.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_00_44_46_c2259488b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

