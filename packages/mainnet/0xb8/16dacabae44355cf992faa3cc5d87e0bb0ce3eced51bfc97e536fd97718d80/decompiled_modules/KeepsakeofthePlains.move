module 0xb816dacabae44355cf992faa3cc5d87e0bb0ce3eced51bfc97e536fd97718d80::KeepsakeofthePlains {
    struct KEEPSAKEOFTHEPLAINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEEPSAKEOFTHEPLAINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEEPSAKEOFTHEPLAINS>(arg0, 0, b"COS", b"Keepsake of the Plains", b"They will ask how you returned... but were you ever really gone?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Torso_Keepsake_of_the_Plains.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEEPSAKEOFTHEPLAINS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEEPSAKEOFTHEPLAINS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

