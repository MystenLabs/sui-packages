module 0x16026e7db8dda355f6e9e553d6af5edd76bfa662fbd0159aaf58f7e3ecb2fad9::ReefedSignature {
    struct REEFEDSIGNATURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEFEDSIGNATURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEFEDSIGNATURE>(arg0, 0, b"COS", b"Reefed Signature", b"Patience, little one... they will return for you... they... remember...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Reefed_Signature.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REEFEDSIGNATURE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEFEDSIGNATURE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

