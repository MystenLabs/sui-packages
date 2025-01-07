module 0x5d641656c8edd08b6804bcfaeadeb1c5ae929abf780f01ef58d9763a6fce2788::gw5 {
    struct GW5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GW5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GW5>(arg0, 6, b"GW5", b"Gorrut Wolnis", b"I catch for the Noe Yerk Jeets in the FML. Parody. Fantasy Memecoin League is not affiliated with any other league or association.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_16_at_17_48_39_bc2b5b50ab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GW5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GW5>>(v1);
    }

    // decompiled from Move bytecode v6
}

