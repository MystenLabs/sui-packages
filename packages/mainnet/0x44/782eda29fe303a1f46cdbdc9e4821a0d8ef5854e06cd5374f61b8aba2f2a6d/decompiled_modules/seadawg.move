module 0x44782eda29fe303a1f46cdbdc9e4821a0d8ef5854e06cd5374f61b8aba2f2a6d::seadawg {
    struct SEADAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADAWG>(arg0, 6, b"SEADAWG", b"SEADAWG on SUI", b"IT'S A FUCKING SENDOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_17_48_05_0979fd3531.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

