module 0x5911ae490250906629494dc21ab3a7cabc03347a559945c16c8dd073a9da88b6::trumpv {
    struct TRUMPV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPV>(arg0, 6, b"TRUMPV", b"TrumpVerse", b"Taking the moonshot to Mars with Trump leading the way!  Your ticket to the ultimate space race  let's make Mars Great Again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_22_54_41_3e9b5bb141.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPV>>(v1);
    }

    // decompiled from Move bytecode v6
}

