module 0x6d8eb66a5926280180594c9b459818b0a10c4a29000138e4e450a291bf085683::Voidnails {
    struct VOIDNAILS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOIDNAILS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOIDNAILS>(arg0, 0, b"COS", b"Voidnails", b"Rotten roots sprouting from the mold of war.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Voidnails.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOIDNAILS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOIDNAILS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

