module 0xd1b9f5a544bd6279bb9c55b672044fa69e2addf16a43c59fa85f9d5fa50625ef::jovi {
    struct JOVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOVI>(arg0, 9, b"JOVI", b"Jovi dogy", b"Jovi is a cute dog, this dog has a Bali Kintamani breed.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4edeaee9-ff24-4d01-b566-a48859fed4e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOVI>>(v1);
    }

    // decompiled from Move bytecode v6
}

