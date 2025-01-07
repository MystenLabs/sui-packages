module 0x4b2a5ced2c983dae9404825d9173c6238b5a1a7fee64f9095e922245b4a40e0d::royal {
    struct ROYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYAL>(arg0, 9, b"ROYAL", b"KING", b"KING is a meme inspired by the spirit of glory and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea4f60cd-4552-43b9-a85f-2b0fe9b2379c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

