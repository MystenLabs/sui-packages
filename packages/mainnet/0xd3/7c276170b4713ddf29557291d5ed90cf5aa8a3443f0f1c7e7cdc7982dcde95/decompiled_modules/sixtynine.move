module 0xd37c276170b4713ddf29557291d5ed90cf5aa8a3443f0f1c7e7cdc7982dcde95::sixtynine {
    struct SIXTYNINE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIXTYNINE>, arg1: 0x2::coin::Coin<SIXTYNINE>) {
        0x2::coin::burn<SIXTYNINE>(arg0, arg1);
    }

    fun init(arg0: SIXTYNINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIXTYNINE>(arg0, 6, b"69", b"69", b"there is only sixty nine initial supply for this super limited token, grab it fast before to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/fpyXR5g/sixtynine.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIXTYNINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIXTYNINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIXTYNINE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIXTYNINE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

