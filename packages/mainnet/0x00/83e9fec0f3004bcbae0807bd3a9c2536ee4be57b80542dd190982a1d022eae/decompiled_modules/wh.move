module 0x83e9fec0f3004bcbae0807bd3a9c2536ee4be57b80542dd190982a1d022eae::wh {
    struct WH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WH>(arg0, 9, b"WH", b"WogHodler", b"For wog nft hodler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93a5e963-9b77-4db1-8b37-a5b0f37d9355.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WH>>(v1);
    }

    // decompiled from Move bytecode v6
}

