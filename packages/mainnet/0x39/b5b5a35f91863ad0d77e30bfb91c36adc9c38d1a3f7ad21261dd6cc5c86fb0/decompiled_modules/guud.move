module 0x39b5b5a35f91863ad0d77e30bfb91c36adc9c38d1a3f7ad21261dd6cc5c86fb0::guud {
    struct GUUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUUD>(arg0, 6, b"GUUD", b"Guud on sui", b"We are guud", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000088445_de8b00e91f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

