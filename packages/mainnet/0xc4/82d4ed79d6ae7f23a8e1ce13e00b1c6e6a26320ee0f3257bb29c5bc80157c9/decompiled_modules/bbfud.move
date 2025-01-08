module 0xc482d4ed79d6ae7f23a8e1ce13e00b1c6e6a26320ee0f3257bb29c5bc80157c9::bbfud {
    struct BBFUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBFUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBFUD>(arg0, 6, b"BBFUD", b"BABY FUD", b"Resurging from the ashes of a premature rug, arose the fug that doesn't quit. His message is clear: he won't stand for scams.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd5503b4_dc82_4887_b04d_fa8f087d4274_73ae677a32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBFUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBFUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

