module 0xf899eaa4288078fcfab84261882e1c33862477b244e935a35846b214619f150::smk {
    struct SMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMK>(arg0, 9, b"SMK", b"Sui Kombat", b"The First Mortal Kombat Token on Sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4e6bb7c-d39f-4b7a-bba5-0cb509840c6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

