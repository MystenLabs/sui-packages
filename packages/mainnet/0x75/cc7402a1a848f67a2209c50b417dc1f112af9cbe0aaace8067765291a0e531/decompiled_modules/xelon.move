module 0x75cc7402a1a848f67a2209c50b417dc1f112af9cbe0aaace8067765291a0e531::xelon {
    struct XELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: XELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XELON>(arg0, 9, b"XELON", b"X", b"We will change the world of Web 3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd390f87-3279-4a3f-a3dc-409644022f92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

