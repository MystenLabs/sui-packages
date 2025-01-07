module 0x92953d8f97b74055f13c3866ee35837bd72cf9d25b8bc5f541884d4fc60eb1d3::witchaat {
    struct WITCHAAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCHAAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCHAAT>(arg0, 6, b"Witchaat", b"Suuuuiwitchaat", b"Witchaaat will give you magic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9766_448167806f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCHAAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCHAAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

