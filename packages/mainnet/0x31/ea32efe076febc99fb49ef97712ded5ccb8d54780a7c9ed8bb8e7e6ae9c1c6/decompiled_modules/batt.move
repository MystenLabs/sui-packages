module 0x31ea32efe076febc99fb49ef97712ded5ccb8d54780a7c9ed8bb8e7e6ae9c1c6::batt {
    struct BATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATT>(arg0, 9, b"BATT", b"Tpain", b"Let's have fun, can Batt make her people better or worse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a525de4-d752-4bdd-bbbf-4033a74b2dfd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

