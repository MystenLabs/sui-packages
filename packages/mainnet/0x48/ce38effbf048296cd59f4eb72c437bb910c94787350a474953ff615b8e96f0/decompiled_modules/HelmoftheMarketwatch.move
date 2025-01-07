module 0x48ce38effbf048296cd59f4eb72c437bb910c94787350a474953ff615b8e96f0::HelmoftheMarketwatch {
    struct HELMOFTHEMARKETWATCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELMOFTHEMARKETWATCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELMOFTHEMARKETWATCH>(arg0, 0, b"COS", b"Helm of the Marketwatch", b"They look to you for protection... but you gaze back... with...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Helm_of_the_Marketwatch.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELMOFTHEMARKETWATCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELMOFTHEMARKETWATCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

