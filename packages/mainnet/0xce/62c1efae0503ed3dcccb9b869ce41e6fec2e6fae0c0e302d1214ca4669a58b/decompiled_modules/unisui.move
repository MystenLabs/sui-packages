module 0xce62c1efae0503ed3dcccb9b869ce41e6fec2e6fae0c0e302d1214ca4669a58b::unisui {
    struct UNISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNISUI>(arg0, 6, b"UNISUI", b"Suinicorn", b"Is a Fish? is a Unicorn? No it's the Suinicorn!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sosu_png_4e62c331fb.bin")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

