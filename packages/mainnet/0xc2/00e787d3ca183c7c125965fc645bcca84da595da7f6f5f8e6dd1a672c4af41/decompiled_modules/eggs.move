module 0xc200e787d3ca183c7c125965fc645bcca84da595da7f6f5f8e6dd1a672c4af41::eggs {
    struct EGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGS>(arg0, 6, b"EGGS", b"Miss Hen", b"Miss Hen has cheap eggs for sale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742073422392.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

