module 0x80bbf6ced911a9f8ab0cbb91addc1d0143fc0008c801da0e268f97426d2c5831::SongoftheHive {
    struct SONGOFTHEHIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONGOFTHEHIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONGOFTHEHIVE>(arg0, 0, b"COS", b"Song of the Hive", b"Music once soared between these trees... Tell me, what do you hear?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Song_of_the_Hive.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SONGOFTHEHIVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONGOFTHEHIVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

