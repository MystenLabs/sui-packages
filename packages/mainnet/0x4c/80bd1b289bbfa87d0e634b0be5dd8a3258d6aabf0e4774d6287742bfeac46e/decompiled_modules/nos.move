module 0x4c80bd1b289bbfa87d0e634b0be5dd8a3258d6aabf0e4774d6287742bfeac46e::nos {
    struct NOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOS>(arg0, 6, b"NOS", b"NOT on SUI", b"Discover Not on SUI $NOS , King Tap To Earn on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IS_Iqcg_QR_400x400_4a94183d1e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

