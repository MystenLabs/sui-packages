module 0x91da748e63616ef181097bbb2a81df27323ee9ddc3ac8abd6f290de5eb667ef7::towlie {
    struct TOWLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOWLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOWLIE>(arg0, 6, b"TOWLIE", b"Towlie the towel", b"I heard you guys love towels", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5769_e5a9b86ec3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOWLIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOWLIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

