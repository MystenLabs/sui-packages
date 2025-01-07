module 0x4e9f38530f7e2b0e82d75a3ccca7633a1a0ce556739cc36d6d9af8156043848d::shepe {
    struct SHEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEPE>(arg0, 6, b"SHEPE", b"SHARK PEPE", x"546865204f4720686173206265656e207265626f726e206173206120736861726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0277_2d094030eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

