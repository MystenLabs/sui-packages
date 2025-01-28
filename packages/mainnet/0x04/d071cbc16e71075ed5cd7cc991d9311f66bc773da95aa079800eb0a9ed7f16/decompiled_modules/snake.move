module 0x4d071cbc16e71075ed5cd7cc991d9311f66bc773da95aa079800eb0a9ed7f16::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"SNAKE", b"SNAKE LUNAR", b"HAPPY CHINA NEW YEAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hbz_Gw_K_Hk_400x400_1f8a332e6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

