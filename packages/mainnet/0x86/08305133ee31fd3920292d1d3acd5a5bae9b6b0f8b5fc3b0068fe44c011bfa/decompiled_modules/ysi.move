module 0x8608305133ee31fd3920292d1d3acd5a5bae9b6b0f8b5fc3b0068fe44c011bfa::ysi {
    struct YSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YSI>(arg0, 6, b"YSI", b"YESONSUI", b"This meme token of YES COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mqdefault_9ed27e9899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

