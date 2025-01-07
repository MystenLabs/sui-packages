module 0x247964134ea867811e54083f8ac6c8c6f2f5af26c99ab4cc4e5fb4ea1e5a8248::nc {
    struct NC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NC>(arg0, 9, b"NC", b"NCAT ", b"We don't like cat but no cat should be homeless ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9aa3984a-ab7d-48f3-959a-3998ce6b2eed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NC>>(v1);
    }

    // decompiled from Move bytecode v6
}

