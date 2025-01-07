module 0x1c029bf105fe932b79bc1e0b7eaaf829fabd33c1e126a73aef9346110ce63cbb::facat {
    struct FACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACAT>(arg0, 9, b"FACAT", b"Wavefather", b"Token has be created by Father of wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e63e41db-5349-4c3f-a7ae-f136406a9df5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FACAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

