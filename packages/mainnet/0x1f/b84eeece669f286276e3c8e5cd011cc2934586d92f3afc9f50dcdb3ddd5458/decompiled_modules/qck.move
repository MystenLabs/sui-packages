module 0x1fb84eeece669f286276e3c8e5cd011cc2934586d92f3afc9f50dcdb3ddd5458::qck {
    struct QCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QCK>(arg0, 9, b"QCK", b"QUACK QUAC", b"First $QCK created by the community. Isn't official from Quack Quack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7711c505-f58f-444e-a3bc-11e8da095b95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

