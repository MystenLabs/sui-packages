module 0x97c7f2a66a07b543ed43d609e20f96ecf1e1865db640394fb7275ce836227346::gender {
    struct GENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENDER>(arg0, 9, b"GENDER", b"Gnd", b"The human gender ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94d0df8f-4215-48e6-b9aa-4c5367c3ea91-1000033252.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GENDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

