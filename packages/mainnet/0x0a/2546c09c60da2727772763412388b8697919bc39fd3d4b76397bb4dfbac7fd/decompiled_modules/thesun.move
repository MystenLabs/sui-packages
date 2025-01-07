module 0xa2546c09c60da2727772763412388b8697919bc39fd3d4b76397bb4dfbac7fd::thesun {
    struct THESUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: THESUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THESUN>(arg0, 6, b"THESUN", b"THE SUN OF ART", x"576527726520747279696e67206372617a79206e6577207468696e67732e576879206e6f7420746865206172742073756e206f662041706f6a616e746920746869732074696d652077652074726965643f0a41726520796f7520726561647920746f206265636f6d652061206d696c6c696f6e616972653f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733010531161.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THESUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THESUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

