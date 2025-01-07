module 0x5075a17aa3a5bc797678579cf757130998f97bc9ae463b5106528a48d7c147ec::cat_meme {
    struct CAT_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT_MEME>(arg0, 9, b"CAT_MEME", b"Snowy", b"Snowy the lucky cat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89a4adce-6f33-4a02-9d9a-452fd939cbb2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

