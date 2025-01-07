module 0xab0b5c50529eb1202774b49b309dbcf47354edcebe3c22104d565b6cc08d5d43::gender {
    struct GENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENDER>(arg0, 9, b"GENDER", b"Gnd", b"The human gender ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18e1de09-ba94-4d77-9d9d-4590df7c8e2c-1000033252.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

