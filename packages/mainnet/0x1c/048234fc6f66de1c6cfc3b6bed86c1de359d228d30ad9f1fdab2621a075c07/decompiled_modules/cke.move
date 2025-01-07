module 0x1c048234fc6f66de1c6cfc3b6bed86c1de359d228d30ad9f1fdab2621a075c07::cke {
    struct CKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CKE>(arg0, 9, b"CKE", b"CAKE", b"TOO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2ed8b4f-51bb-4b4b-b109-19ce1607f6a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

