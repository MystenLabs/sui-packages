module 0xda5b2a6e57f80ccd83416a27e4ad9583fd29eaba77f8616520960db5a776fc82::h20dog {
    struct H20DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: H20DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H20DOG>(arg0, 6, b"H20DOG", b"Water Dog", b"The Portuguese Water Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Portrait_of_one_brown_portuguese_water_dog_sticking_out_the_tongue_outdoors_on_the_beach_under_a_blue_sky_in_the_background_Alessandra_Sawick_Shutterstock_65927fe3ef.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H20DOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H20DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

