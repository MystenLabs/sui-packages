module 0x20bfbc0381e3f36b1cac0b37440b737217084317b8be9f3362f114ef788a3186::kid {
    struct KID has drop {
        dummy_field: bool,
    }

    fun init(arg0: KID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KID>(arg0, 6, b"Kid", b"Crypto Kid", x"5468697320697320746865204469617279206f6620412043727970746f204b6964200a4752414220594f555220444941525920414e44204c4554532047455420544f204d414b494e4720412053544f525920414e5920444547454e204b49442043414e20445245414d204f4621", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8861_92a5ec9c2c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KID>>(v1);
    }

    // decompiled from Move bytecode v6
}

