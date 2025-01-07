module 0x90422245604ce84e3ef5b59b75f4a6bfc490eceb8dda0ddfea80bd3ff6a8cada::CalloftheGreatSphere {
    struct CALLOFTHEGREATSPHERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CALLOFTHEGREATSPHERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CALLOFTHEGREATSPHERE>(arg0, 0, b"COS", b"Call of the Great Sphere", b"Why does it call? Why does it so draw us in?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Call_of_the_Great_Sphere.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CALLOFTHEGREATSPHERE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CALLOFTHEGREATSPHERE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

