module 0xca9c2fe6decca9b330f81922e5bc4d49f66a1f5b4cf04844aaa93d3b13ddf069::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 6, b"Ponke", b"PONKEsui", b"The first ponke on sui to reach 8 figure mc ! Get ready for an epic ride! All social will be shared later to avoid a PnD at early stage!Shill in all your private and take your position! Welcome aboard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0405_267f408015.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

