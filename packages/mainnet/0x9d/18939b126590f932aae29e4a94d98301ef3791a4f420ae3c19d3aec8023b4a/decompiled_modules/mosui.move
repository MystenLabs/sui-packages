module 0x9d18939b126590f932aae29e4a94d98301ef3791a4f420ae3c19d3aec8023b4a::mosui {
    struct MOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSUI>(arg0, 6, b"MOSUI", b"PIXEL MODENG", b"Meet Moo Deng, the adorable baby pixel pygmy hippo whos quickly become the SUI favorite animal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_16_19_46b4fb0f26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

