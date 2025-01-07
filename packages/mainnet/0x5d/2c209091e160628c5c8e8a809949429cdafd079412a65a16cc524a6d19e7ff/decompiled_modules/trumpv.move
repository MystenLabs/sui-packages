module 0x5d2c209091e160628c5c8e8a809949429cdafd079412a65a16cc524a6d19e7ff::trumpv {
    struct TRUMPV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPV>(arg0, 6, b"TRUMPV", b"TrumpVerse", b"Taking the moonshot to Mars with Trump leading the way!  Your ticket to the ultimate space race  let's make Mars Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_22_54_41_7a2010b5c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPV>>(v1);
    }

    // decompiled from Move bytecode v6
}

