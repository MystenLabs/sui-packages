module 0x7c9cc1004b545e96d67b6298a4330d1ceef9caac0f0ee1f18fd30885b01cc862::smn {
    struct SMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMN>(arg0, 6, b"SMN", b"SUIMAN", b"SUIMAN TOKEN MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/superman_meme_illustration_wallpaper_dfd295b9e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

