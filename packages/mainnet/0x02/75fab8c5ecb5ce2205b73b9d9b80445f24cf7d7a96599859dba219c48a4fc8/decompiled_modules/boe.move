module 0x275fab8c5ecb5ce2205b73b9d9b80445f24cf7d7a96599859dba219c48a4fc8::boe {
    struct BOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOE>(arg0, 9, b"BOE", b"BEYONCE", b"Meme beyonce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2546ba63-6e8e-4eab-b0dc-87c7a65dd930.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

