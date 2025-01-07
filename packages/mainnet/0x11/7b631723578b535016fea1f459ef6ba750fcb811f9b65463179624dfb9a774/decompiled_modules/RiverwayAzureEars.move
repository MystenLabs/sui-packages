module 0x117b631723578b535016fea1f459ef6ba750fcb811f9b65463179624dfb9a774::RiverwayAzureEars {
    struct RIVERWAYAZUREEARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIVERWAYAZUREEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIVERWAYAZUREEARS>(arg0, 0, b"COS", b"Riverway Azure Ears", b"Splashed with the ramble of countless travels-now children of the Ward.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Riverway_Azure_Ears.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIVERWAYAZUREEARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIVERWAYAZUREEARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

