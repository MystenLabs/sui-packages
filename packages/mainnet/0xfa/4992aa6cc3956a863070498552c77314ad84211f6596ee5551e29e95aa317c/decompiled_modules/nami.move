module 0xfa4992aa6cc3956a863070498552c77314ad84211f6596ee5551e29e95aa317c::nami {
    struct NAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMI>(arg0, 6, b"NAMI", b"Suinami", b"where the power of a tsunami meets the playful spirit of a surf-loving Shiba Inu. This isnt just another token; its a tidal wave of innovation on the Sui Blockchain. Surfing through the crypto market with unparalleled speed and agility, $Suinami represents the force of nature in the world of digital currency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037938_898132f9ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

