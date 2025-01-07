module 0x35ef33c13981e03d94f207b3310dbc721f3c77e56d248bb0b2e67df7bcbd2407::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"Sui Boom", b"$BOOM  is a dynamic project on the Sui Network, designed to combat bearish trends in the crypto space. Our playful cartoon bomb character splashes water to create waves of positivity, fueling the bull market. With innovative ideas and a vibrant community, we aim to keep the energy high and the bears at bay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000043782_4973d465b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

