module 0x879441f7c757ca9d12f6cec01d62f09caf1b3ac7cbc1c03f9fea6233d063768c::smokingbird {
    struct SMOKINGBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKINGBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKINGBIRD>(arg0, 6, b"SMOKINGBIRD", b"Smoking Bird", b"It's a bird smoking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smoke_bird_by_danggles2_d986bk5_375w_2x_b682821e0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKINGBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKINGBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

