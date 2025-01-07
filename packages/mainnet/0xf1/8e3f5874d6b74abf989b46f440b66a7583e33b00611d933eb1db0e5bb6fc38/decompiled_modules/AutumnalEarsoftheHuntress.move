module 0xf18e3f5874d6b74abf989b46f440b66a7583e33b00611d933eb1db0e5bb6fc38::AutumnalEarsoftheHuntress {
    struct AUTUMNALEARSOFTHEHUNTRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTUMNALEARSOFTHEHUNTRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTUMNALEARSOFTHEHUNTRESS>(arg0, 0, b"COS", b"Autumnal Ears of the Huntress", b"The touch of melancholy, song of changes...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Autumnal_Ears_of_the_Huntress.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUTUMNALEARSOFTHEHUNTRESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTUMNALEARSOFTHEHUNTRESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

