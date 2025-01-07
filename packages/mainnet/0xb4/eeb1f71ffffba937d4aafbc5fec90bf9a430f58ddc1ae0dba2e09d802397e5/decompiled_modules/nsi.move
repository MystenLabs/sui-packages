module 0xb4eeb1f71ffffba937d4aafbc5fec90bf9a430f58ddc1ae0dba2e09d802397e5::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"Notsui", b"Notsui not pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba321256-905f-4331-9114-153f623a24ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

