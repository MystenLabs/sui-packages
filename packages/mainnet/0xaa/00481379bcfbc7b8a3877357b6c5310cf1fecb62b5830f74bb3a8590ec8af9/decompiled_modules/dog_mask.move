module 0xaa00481379bcfbc7b8a3877357b6c5310cf1fecb62b5830f74bb3a8590ec8af9::dog_mask {
    struct DOG_MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_MASK>(arg0, 9, b"DOG_MASK", b"Dogwifmask", b"Just a dog with mask ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/89def717-d3ec-4ff4-81f4-129b07334e59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

