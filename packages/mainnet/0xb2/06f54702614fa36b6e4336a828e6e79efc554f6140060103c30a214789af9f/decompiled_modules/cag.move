module 0xb206f54702614fa36b6e4336a828e6e79efc554f6140060103c30a214789af9f::cag {
    struct CAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAG>(arg0, 6, b"CAG", b"Cap Dog", b"Cap Dog dive into water coming to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rr_Bfo_Hg0_400x400_592067bfa8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

