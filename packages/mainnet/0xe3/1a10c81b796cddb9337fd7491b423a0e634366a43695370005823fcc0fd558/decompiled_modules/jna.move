module 0xe31a10c81b796cddb9337fd7491b423a0e634366a43695370005823fcc0fd558::jna {
    struct JNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNA>(arg0, 9, b"JNA", b"JANATA", b"Meem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d3aa072-4252-493c-9b24-a4f4563fc14c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

