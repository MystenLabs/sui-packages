module 0x779dc4710dde5ef66ce958fc31842a73157b4265b90b3d49cdd9b6c38c7403cc::blet {
    struct BLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLET>(arg0, 6, b"BLET", b"BrainletSui", b"https://brainletsui.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_220722_bd93cdaf21.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

