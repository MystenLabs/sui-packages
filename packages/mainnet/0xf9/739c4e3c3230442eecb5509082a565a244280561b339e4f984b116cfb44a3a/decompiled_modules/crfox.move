module 0xf9739c4e3c3230442eecb5509082a565a244280561b339e4f984b116cfb44a3a::crfox {
    struct CRFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRFOX>(arg0, 6, b"CRFOX", b"CRIMSON FOX", b"Swift, sly, and dangerously cute. Crimson Fox is the predator of meme charts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_035846266_73c5001d73.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

