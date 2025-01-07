module 0x67ea847c0656d3ddc7008a89e6c4c326a2cb779a38d6e0e7229953225eeafb4c::xrth {
    struct XRTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRTH>(arg0, 9, b"XRTH", b"Xyroth on Sui", b"Xyroth, the \"Interstellar Enforcer,\" is a legendary blue alien and guardian of the cosmic frontier, now connected to the cutting-edge Sui blockchain. With glowing red eyes and a neon-infused leather suit, he wields unyielding power and fearless determination. As the last survivor of an ancient Martian race, Xyroth protects his ancestral home while leveraging the Sui blockchain to monitor and thwart intergalactic threats in real time. Silent but deadly, he ensures justice prevails across the galaxy, embodying resilience, innovation, and the relentless spirit of the unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/16a10f397ab999ed04a8d8a0c13d17aeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XRTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

