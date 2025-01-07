module 0x4566f4c724b2486a826046d9ac54f3de692855ca6794f4946cb49f28ce9f43e::knut {
    struct KNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNUT>(arg0, 6, b"KNUT", b"SUIKUT", b"KNUTSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mem1_103fb582cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

