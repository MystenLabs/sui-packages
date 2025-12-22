module 0x31c289267bb89f96d3365a8a3c2c4add50f3e5c104b5b010173d2163a2812e5e::PI {
    struct PI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PI>, arg1: 0x2::coin::Coin<PI>) {
        0x2::coin::burn<PI>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PI>>(0x2::coin::mint<PI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 4, b"PI", b"PI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/pi_network.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

