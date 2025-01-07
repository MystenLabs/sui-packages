module 0xf04095c46b4ee1993172eb1890c85c9fed87ea6ed5a9085a3942cee2179402a1::ciko {
    struct CIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKO>(arg0, 6, b"CIKO", b"ciko cats", b"SAY IT! SUI IT! THE CATS ARE BACK IN TOWN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000119234_c30052ccfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

