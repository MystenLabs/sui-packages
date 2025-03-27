module 0xe4e49da0501b08dd582320f2d4fa65d94519235964d9785e0a7c1c4d13b1fd5d::duak {
    struct DUAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUAK>(arg0, 6, b"DUAK", b"duak", x"4c697665206e6f77206f6e206d6f766570756d700a0a5447203a2068747470733a2f2f742e6d652f6475616b5f7375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Hk_Qz_Idu_400x400_ca6055cd90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

