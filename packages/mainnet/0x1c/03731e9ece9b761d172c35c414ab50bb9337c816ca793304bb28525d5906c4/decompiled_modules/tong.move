module 0x1c03731e9ece9b761d172c35c414ab50bb9337c816ca793304bb28525d5906c4::tong {
    struct TONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONG>(arg0, 6, b"TONG", b"Tong on Sui", b"Tong is the official Chinese name for Trump. We are the first Trump memecoin with a cultural twist to amass supporters from the Chinese market. Whilst divided by land, we unite together under the same goal to Make America Great Again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036388_16663a8ced.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

