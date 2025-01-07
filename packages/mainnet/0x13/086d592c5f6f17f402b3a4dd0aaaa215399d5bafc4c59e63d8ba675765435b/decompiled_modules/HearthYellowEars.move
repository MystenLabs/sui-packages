module 0x13086d592c5f6f17f402b3a4dd0aaaa215399d5bafc4c59e63d8ba675765435b::HearthYellowEars {
    struct HEARTHYELLOWEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEARTHYELLOWEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEARTHYELLOWEARS>(arg0, 0, b"COS", b"Hearth Yellow Ears", b"Waxed with the colors of wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Hearth_Yellow_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEARTHYELLOWEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEARTHYELLOWEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

