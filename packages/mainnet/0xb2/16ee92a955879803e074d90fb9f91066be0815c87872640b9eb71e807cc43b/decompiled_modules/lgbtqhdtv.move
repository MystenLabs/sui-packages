module 0xb216ee92a955879803e074d90fb9f91066be0815c87872640b9eb71e807cc43b::lgbtqhdtv {
    struct LGBTQHDTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGBTQHDTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGBTQHDTV>(arg0, 6, b"LGBTQHDTV", b"LGBTQHDTV+", b"I identify as an NeoQLED flatscreen.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tv_ff13a93a92.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBTQHDTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LGBTQHDTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

