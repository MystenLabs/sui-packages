module 0xd60b62ef478efa83593fc54984a06963dc4943e826979a5f512c0ffbc4707daf::sro {
    struct SRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRO>(arg0, 6, b"SRO", b"Suiranno", b"Suirrano is a symbol of courage, loyalty, and fierce protection, just like the Serrano dog its based on. Unlike typical meme coins that rely on internet jokes, or even pointless animal cartoons with no meaning, Suirrano draws inspiration from the noble traits of the Serrano dog, embodying strength and unwavering devotion. The memes associated with Suirrano aren't just for laughs; they serve as a reflection of today's society, capturing the challenges and complexities of our time with honesty and wit. Suirrano represents more than just a coin, its a movement built on resilience and truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/circ_b7ee28e168.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

