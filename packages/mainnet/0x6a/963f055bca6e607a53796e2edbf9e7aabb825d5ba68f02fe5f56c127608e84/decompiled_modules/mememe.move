module 0x6a963f055bca6e607a53796e2edbf9e7aabb825d5ba68f02fe5f56c127608e84::mememe {
    struct MEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEME>(arg0, 9, b"MEMEME", b"Tokenmemem", b"Memetokenmeme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3adfcebf-98cc-4295-9b70-5d40958a8e31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

