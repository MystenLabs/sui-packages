module 0xc6d00883ae22c33f1a67258d81044c96769dce2af061efbdcb9523d4a9bad145::blui {
    struct BLUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUI>(arg0, 6, b"BLUI", b"BLUI On Sui", b"Blui is the chillest memecoin on MovePump  a light-blue, soft-spoken symbol of steady vibes in the chaos of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluionsui_c7ce318206.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

