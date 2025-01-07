module 0xd26a60cab000d79b213b5f1db91cbe8f5e67388e31d8e6a71fd3333e7eb600c::ali {
    struct ALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALI>(arg0, 9, b"ALI", b"Ahmad", b"This is best coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38c17682-3edf-4f75-877f-432e0193c186.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALI>>(v1);
    }

    // decompiled from Move bytecode v6
}

