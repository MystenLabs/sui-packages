module 0xe95249b61e159d84e17ec9eb23ee596fab77b4c47af1108b10751c543a612ff0::dmx {
    struct DMX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMX>(arg0, 6, b"DMX", b"PSP", x"4465762077686572652061726520796f75204465763f0a497427732074696d6520666f7220446576", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_d652a28bec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMX>>(v1);
    }

    // decompiled from Move bytecode v6
}

