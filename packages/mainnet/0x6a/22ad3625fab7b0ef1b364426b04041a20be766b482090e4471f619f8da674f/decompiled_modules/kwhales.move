module 0x6a22ad3625fab7b0ef1b364426b04041a20be766b482090e4471f619f8da674f::kwhales {
    struct KWHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWHALES>(arg0, 6, b"KWHALES", b"KWHALES BOT", b"PREPARE FOR THE NEW MOVEPUMP BOT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dd403842c594c809aa299e55251262af_d065ab9aa1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KWHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

