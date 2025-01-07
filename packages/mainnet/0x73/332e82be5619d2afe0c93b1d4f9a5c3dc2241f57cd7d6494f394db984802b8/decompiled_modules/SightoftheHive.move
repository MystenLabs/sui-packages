module 0x73332e82be5619d2afe0c93b1d4f9a5c3dc2241f57cd7d6494f394db984802b8::SightoftheHive {
    struct SIGHTOFTHEHIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGHTOFTHEHIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGHTOFTHEHIVE>(arg0, 0, b"COS", b"Sight of the Hive", b"Piercing gaze of the airborne, the winged prey.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Sight_of_the_Hive.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIGHTOFTHEHIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGHTOFTHEHIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

