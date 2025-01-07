module 0xfca6207f95f0d250c763f4ae5a3741e30b3e35fba50cb4ac23b20fee43684c09::saxol {
    struct SAXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAXOL>(arg0, 6, b"SAXOL", b"SuiAxolodl", b"Vision sui meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021992_1d51142366.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

