module 0x38a27ff88c929f450e719876664c6945f4dd79ce8787ddb9e91de287660cc21c::WAVE {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"Sui Riders", b"WAVE", b"Ride the Sui wave to the moon with $WAVE! This meme coin is all about vibing, surfing the crypto tides, and yelling 'bruhhhh' as you hodl. Whether you're a degen or a diamond-hander, $WAVE is your ticket to the ultimate meme-fueled gains. Catch the wave or get left behind!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/w1q5vq6UOpa9O9nzyQycdQo5LWqnust6GONLzDZ6qCF29fiKA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, @0x82ea3f8d2475bae1d2aba484c46125fdb81e0f192172e398c2ee99d9813cea00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

