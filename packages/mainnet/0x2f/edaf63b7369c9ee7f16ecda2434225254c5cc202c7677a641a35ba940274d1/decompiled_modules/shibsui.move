module 0x2fedaf63b7369c9ee7f16ecda2434225254c5cc202c7677a641a35ba940274d1::shibsui {
    struct SHIBSUI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBSUI>, arg1: 0x2::coin::Coin<SHIBSUI>) {
        0x2::coin::burn<SHIBSUI>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIBSUI>>(0x2::coin::mint<SHIBSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHIBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBSUI>(arg0, 6, b"SHIBSUI", b"SHIB ON SUI", b"The original Shiba meme coin on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/Njs08CDM/sshib512.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIBSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

