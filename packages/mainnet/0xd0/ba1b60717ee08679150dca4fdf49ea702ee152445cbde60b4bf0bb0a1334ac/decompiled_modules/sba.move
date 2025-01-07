module 0xd0ba1b60717ee08679150dca4fdf49ea702ee152445cbde60b4bf0bb0a1334ac::sba {
    struct SBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBA>(arg0, 9, b"SBA", b"vann samba", b"Build with smart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0aea5f92-98cf-42d0-96cb-74b6ff550a04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

