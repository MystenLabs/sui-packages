module 0x89b372e8e0f6a5001bc471e4e29a1c7f8ec04c1baea615447b40cc1f30a78410::dogskaka {
    struct DOGSKAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAKA>(arg0, 9, b"DOGSKAKA", b"WAWE", b"I won mis to kanfnc mfnajxj sksnxn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/70a70ef7-5a55-4f04-9f35-b3ffe3dff81a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

