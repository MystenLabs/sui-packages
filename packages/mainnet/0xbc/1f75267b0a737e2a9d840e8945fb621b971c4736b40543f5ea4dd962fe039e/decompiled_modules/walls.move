module 0xbc1f75267b0a737e2a9d840e8945fb621b971c4736b40543f5ea4dd962fe039e::walls {
    struct WALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLS>(arg0, 6, b"WALLS", b"Wall sui Boys", b"Wall street wolfs on the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027953_31985c1bd4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

