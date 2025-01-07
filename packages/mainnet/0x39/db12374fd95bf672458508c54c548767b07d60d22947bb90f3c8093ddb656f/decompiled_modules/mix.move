module 0x39db12374fd95bf672458508c54c548767b07d60d22947bb90f3c8093ddb656f::mix {
    struct MIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIX>(arg0, 9, b"MIX", b"Mixset", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d89a14eb-3b95-4cf2-a9f1-e5f9c8511561.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

