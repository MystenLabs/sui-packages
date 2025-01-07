module 0xd7e983f4a22bd332240c7cf27f71173fdda7c8f1c104d8366b997cb63f755499::iekdb {
    struct IEKDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IEKDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IEKDB>(arg0, 9, b"IEKDB", b"heidn", b"gdbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0963975-5f9c-42ec-a7fa-353723ee4bea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IEKDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IEKDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

