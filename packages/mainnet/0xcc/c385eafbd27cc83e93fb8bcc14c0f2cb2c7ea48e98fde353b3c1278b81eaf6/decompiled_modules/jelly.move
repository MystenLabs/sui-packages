module 0xccc385eafbd27cc83e93fb8bcc14c0f2cb2c7ea48e98fde353b3c1278b81eaf6::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"Jelly of Sui", b"Wobbly but tough! $JELLY floats through the Sui waters with a bounce, bringing some jellyfish vibes to the network. Dont let its soft look fool youits got sting and style, gliding smoothly through the currents of Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jelly_1_e841a7ce10.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

