module 0x59efc1cda39c9f805d1e99c72a899f0478636f09d35e31f0df8aa085acac1740::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"Notsui", b"Notsui not pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78064884-df2d-454c-9f33-80d7dc5c8b83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

