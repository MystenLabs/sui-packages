module 0x131b7c8e7b165fb8355c651b14e81d5854c854946adfc01f88cbabfc954f6171::esthy_45 {
    struct ESTHY_45 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTHY_45, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTHY_45>(arg0, 9, b"ESTHY_45", b"Esthy", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2ec6e29-da0d-47b1-9293-5881daa915bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTHY_45>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESTHY_45>>(v1);
    }

    // decompiled from Move bytecode v6
}

