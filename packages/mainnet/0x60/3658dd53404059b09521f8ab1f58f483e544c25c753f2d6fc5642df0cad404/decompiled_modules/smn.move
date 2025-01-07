module 0x603658dd53404059b09521f8ab1f58f483e544c25c753f2d6fc5642df0cad404::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 6, b"SMN", b"SUIMAN", b"SUIMAN TOKEN MEME GOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/superman_meme_illustration_wallpaper_40870cc732.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

