module 0x22d72dd12933ef92d2bf86f9299f4fd00d3dd0d4524409d72cd7699fcebf3342::zac {
    struct ZAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"nZAC";
        0x1::vector::remove<u8>(&mut v0, 0);
        let v1 = b"dZac";
        0x1::vector::remove<u8>(&mut v1, 0);
        let (v2, v3) = 0x2::coin::create_currency<ZAC>(arg0, 6, b"ZAC", v0, v1, 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suidotfun.onrender.com/i/W1Tk1UutztF_WYOW")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAC>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

