module 0x43e02cefb9094fa1cf32a75528ac0cc95231b97f2c00ba02d1a9d9e90814a97f::EarsoftheHuntress {
    struct EARSOFTHEHUNTRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARSOFTHEHUNTRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARSOFTHEHUNTRESS>(arg0, 0, b"COS", b"Ears of the Huntress", b"Slip through the seams of the forest... awaken to its loving precision...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Ears_of_the_Huntress.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARSOFTHEHUNTRESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARSOFTHEHUNTRESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

