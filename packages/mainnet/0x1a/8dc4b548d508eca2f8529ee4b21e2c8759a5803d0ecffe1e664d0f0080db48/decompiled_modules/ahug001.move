module 0x1a8dc4b548d508eca2f8529ee4b21e2c8759a5803d0ecffe1e664d0f0080db48::ahug001 {
    struct AHUG001 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHUG001, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHUG001>(arg0, 9, b"AHUG001", b"AHUG", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a5ad14fe-9b16-4c02-b04e-86a91cf79b75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHUG001>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHUG001>>(v1);
    }

    // decompiled from Move bytecode v6
}

