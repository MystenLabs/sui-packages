module 0x83ea05a926867af64dc905c04006e9ca9d7cc3a387769b19e6f731f72ec606fe::dragsui {
    struct DRAGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGSUI>(arg0, 6, b"Dragsui", b"DragonSea", b"King Of Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_09_at_01_44_29_9b77067c_ce9c566a31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

