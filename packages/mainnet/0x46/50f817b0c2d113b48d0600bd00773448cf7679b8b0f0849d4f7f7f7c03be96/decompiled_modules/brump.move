module 0x4650f817b0c2d113b48d0600bd00773448cf7679b8b0f0849d4f7f7f7c03be96::brump {
    struct BRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUMP>(arg0, 6, b"BRUMP", b"Brett Trump", b"Brump, the revolutionary memecoin that merges the satirical essence of internet culture with the larger-than-life persona of Brett, in a nod to the infamous Trump era. Born from the digital playground ofmemes and crypto, Brump stands as a testament to the power of humor and innovation in the ever-evolvinglandscape of cryptocurrencies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/180x180_0740f92222.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

