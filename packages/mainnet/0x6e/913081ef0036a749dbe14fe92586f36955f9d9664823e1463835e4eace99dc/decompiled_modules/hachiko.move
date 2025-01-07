module 0x6e913081ef0036a749dbe14fe92586f36955f9d9664823e1463835e4eace99dc::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HACHIKO>(arg0, 6, b"HACHIKO", b"First Hachiko on Sui", b"First $Hachiko on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/haki2_8d08933cad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

