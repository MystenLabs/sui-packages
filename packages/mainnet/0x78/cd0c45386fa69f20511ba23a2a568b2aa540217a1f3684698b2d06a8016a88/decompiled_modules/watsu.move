module 0x78cd0c45386fa69f20511ba23a2a568b2aa540217a1f3684698b2d06a8016a88::watsu {
    struct WATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATSU>(arg0, 6, b"WATSU", b"Sui On Water", b"Water On Sui is #Sui's Beloved Mascot Token! Dive Into The refreshing World #Water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000210673_3264a126b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

