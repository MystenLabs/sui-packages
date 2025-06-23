module 0xad180784e74cee2b24f24882fea70bdeb85aa90008745a9faca0b754d7727029::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"OG Blui On Sui", b"Blui is the chillest memecoin on  MovePump a light-blue, soft-spoken symbol of steady vibes in the chaos of crypto. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluionsui_9190fa2b22.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

