module 0x9566998587df1f07716d44a8d7773f4094b13930db60cad1daee016aa4263b6::wsx {
    struct WSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSX>(arg0, 9, b"WSX", b"WSUIX", b"Wave sui x - For the development of the network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea946e1a-30ae-4255-82ba-654933013603.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

