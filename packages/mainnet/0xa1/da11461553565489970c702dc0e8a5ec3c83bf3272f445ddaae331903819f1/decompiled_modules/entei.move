module 0xa1da11461553565489970c702dc0e8a5ec3c83bf3272f445ddaae331903819f1::entei {
    struct ENTEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTEI>(arg0, 6, b"ENTEI", b"Dog In A Cats Wor", x"24454e5445490a68747470733a2f2f742e6d652f535549454e5445495f506f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_11_16_01_94266e89ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENTEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

