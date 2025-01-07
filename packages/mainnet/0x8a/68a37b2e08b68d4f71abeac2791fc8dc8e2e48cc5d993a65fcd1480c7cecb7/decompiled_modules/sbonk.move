module 0x8a68a37b2e08b68d4f71abeac2791fc8dc8e2e48cc5d993a65fcd1480c7cecb7::sbonk {
    struct SBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBONK>(arg0, 6, b"SBONK", b"SHUIBONK", x"436f6d6d756e69747920696e204d696e642c204d656d652061742048656172742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A9c5_Lv_T2_400x400_a0c9afdd97.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

