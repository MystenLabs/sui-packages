module 0x493ac42570857a1944b901df449e1e1ac722a42cc81c21975712a8501025b2ef::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"ALIEN", b"alien antics", b"dancing in zero gravity, maybe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_04_17_52_57_28e1ea9208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

