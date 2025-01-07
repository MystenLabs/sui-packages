module 0x9ed033b3a0c313797485b1bf7789480365b4eb22f22dc4b8c3e9f837512749bf::mello {
    struct MELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELLO>(arg0, 6, b"MELLO", b"MELLO on SUI", b"$mello the @doodles cat as seen in @McDonalds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_18_15_03_20_removebg_preview_ec66822528.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

