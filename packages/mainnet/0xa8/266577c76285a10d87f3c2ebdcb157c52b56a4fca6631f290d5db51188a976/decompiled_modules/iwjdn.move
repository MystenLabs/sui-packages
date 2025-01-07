module 0xa8266577c76285a10d87f3c2ebdcb157c52b56a4fca6631f290d5db51188a976::iwjdn {
    struct IWJDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWJDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWJDN>(arg0, 9, b"IWJDN", b"sinsn", b"idksnwb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21bd6919-1cd9-4a33-a5eb-082dbd4e1464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWJDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWJDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

