module 0xfacffd99c93a984c749ad1f44b8784a24edddd0ffdafe722fc04cf03429a581f::nut {
    struct NUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUT>(arg0, 6, b"NUT", b"Buster", b"Laugh all you want, but youll feel the impact when this hits the memecoin scene. Make sure you're on the winning side before it all cracks open.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3413_9394480458.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

