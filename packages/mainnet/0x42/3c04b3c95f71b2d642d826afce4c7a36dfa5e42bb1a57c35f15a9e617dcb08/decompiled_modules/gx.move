module 0x423c04b3c95f71b2d642d826afce4c7a36dfa5e42bb1a57c35f15a9e617dcb08::gx {
    struct GX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GX>(arg0, 9, b"GX", b"Galaxyr", b"Born from a black hole's sneeze, Galaxyr fuels intergalactic memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dstqcb0lj/image/upload/v1739260112/d4vxmirahjgmkq2471pm.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GX>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GX>>(v1);
    }

    // decompiled from Move bytecode v6
}

