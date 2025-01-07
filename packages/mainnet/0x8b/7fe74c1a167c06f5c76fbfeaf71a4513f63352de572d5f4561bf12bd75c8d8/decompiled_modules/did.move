module 0x8b7fe74c1a167c06f5c76fbfeaf71a4513f63352de572d5f4561bf12bd75c8d8::did {
    struct DID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DID>(arg0, 9, b"DID", b"DIDDY", b"Just a meme Coin on PDiddy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59ccce5a-41f5-4508-b294-c9f16a6f51cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DID>>(v1);
    }

    // decompiled from Move bytecode v6
}

