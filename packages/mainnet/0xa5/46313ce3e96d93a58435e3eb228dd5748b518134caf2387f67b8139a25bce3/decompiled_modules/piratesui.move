module 0xa546313ce3e96d93a58435e3eb228dd5748b518134caf2387f67b8139a25bce3::piratesui {
    struct PIRATESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRATESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRATESUI>(arg0, 6, b"PIRATESUI", b"Pirates Of Sui", b"Pirates of Sui $PIRATESUI is a meme coin sailing the Sui network, designed purely for fun and community engagement. This lighthearted token aims to unite adventurers across the Sui ecosystem, helping everyone reach their goals while embracing the spirit of camaraderie and exploration. Join the crew and chart a course for success with Pirates of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pirates_of_sui_logo_1000_x_1000_px_463af6849f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRATESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRATESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

