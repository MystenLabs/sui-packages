module 0x28764ce219ec3b9137fc1921a8a946698e2e544f3afbcdfe06af2eb1bebcfe04::BootsfortheBrrr {
    struct BOOTSFORTHEBRRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTSFORTHEBRRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTSFORTHEBRRR>(arg0, 0, b"COS", b"Boots for the Brrr", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Feet_Boots_for_the_Brrr.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOTSFORTHEBRRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTSFORTHEBRRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

