module 0xebb053eb43bc292fa97fbad0d27f01976ce59d598148b9f729fdad1bbaf1fc48::hf {
    struct HF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HF>(arg0, 9, b"HF", b"HOOF", b"Hoof is a meme inspired by the spirit of crypto bullrun. With Hoof, we are not just riding the Hoof - we are mastering it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/961f65da-2967-4e99-a0ce-34b542414a83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HF>>(v1);
    }

    // decompiled from Move bytecode v6
}

