module 0x3c926bb47780afddfed2b47df71b3731bed352779995034ca1f6074b5da9ebbc::psg {
    struct PSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSG>(arg0, 6, b"PSG", b"Pixel SUI GIRL", b"Pixel Sui Girl is a vibrant, retro-styled character with pixelated charm, representing creativity on the Sui blockchain. She symbolizes tech innovation with a playful, futuristic twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8b2931cb54aab2958a50078509ff9415_3633157b4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

