module 0x8e6b4b1cbbba37acf736193a4c63fe9d0f7001d78a9bb63255ae9547edea6a38::omg {
    struct OMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMG>(arg0, 9, b"OMG", b"oimaisgots", b"sup rai to be con to new", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/908faa63-c9f8-4866-ac1d-d86871109a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

