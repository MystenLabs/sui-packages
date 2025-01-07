module 0x31df7aa6116070a3a82e4157fcd05abea6a947866fffef04dcbe580347e6dbdd::ForestShroudedEars {
    struct FORESTSHROUDEDEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORESTSHROUDEDEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORESTSHROUDEDEARS>(arg0, 0, b"COS", b"Forest-Shrouded Ears", b"A saintly gloom has fallen... for who can hear what is lost?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Forest-Shrouded_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORESTSHROUDEDEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORESTSHROUDEDEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

