module 0xe7bfd1bfec303724fc3f5f4bf0c7052cb9b1bb9c1b5c9ff514bd5578c3f482c::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 9, b"BOB", b"Spongebob ", b"The phenomenal Spongebob cartoon entertained us during our childhood and was fun. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d772d58-e305-489e-b325-b1bd86fe2fe0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

