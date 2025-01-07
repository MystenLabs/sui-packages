module 0x563235c8ab12067eb5acd5a1ae964f018c4aa9fbdbd67b790795e86c75e784f6::bid {
    struct BID has drop {
        dummy_field: bool,
    }

    fun init(arg0: BID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BID>(arg0, 9, b"BID", b"Big Dog", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/488472bf-6f16-4925-b394-e465d58c4cec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BID>>(v1);
    }

    // decompiled from Move bytecode v6
}

