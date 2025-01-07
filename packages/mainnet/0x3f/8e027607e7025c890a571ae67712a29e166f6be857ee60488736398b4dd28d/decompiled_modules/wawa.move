module 0x3f8e027607e7025c890a571ae67712a29e166f6be857ee60488736398b4dd28d::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 6, b"WAWA", b"WAWAACTO", b"Why did the sneaky Wawa cat jump into $wawa ?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_5ad1243063.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

