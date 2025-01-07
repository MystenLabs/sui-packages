module 0x2b7f1906f915d38b6e1474d69609eebe2306ab7e0f948645fe4e5c17c4a717df::mikasa {
    struct MIKASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKASA>(arg0, 9, b"MIKASA", b"Mikasa Ack", b"Mikasa Ackermann is a fictional character from Hajime Isayama's manga series Attack on Titan.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec219c55-a560-46e3-94fb-c72e368d9511.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIKASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

