module 0xdcc0a8ae2ab8ff05cb7199168913391c9d5522f46d090dc7b14009bb89a4d371::doxxy {
    struct DOXXY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOXXY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOXXY>(arg0, 9, b"DOXXY", b"Foxxy", b"For fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/45cdc48b-b04a-44e4-984b-8568ce50ae58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOXXY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOXXY>>(v1);
    }

    // decompiled from Move bytecode v6
}

