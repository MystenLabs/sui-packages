module 0x509d61a0cfd3a36217666da518db775eca52911840df9d633403a8e1fd63a935::je {
    struct JE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JE>(arg0, 9, b"JE", b"Tb", b"Wd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/031dbe84-dcb9-4a42-9cc8-4dacc073dff4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JE>>(v1);
    }

    // decompiled from Move bytecode v6
}

