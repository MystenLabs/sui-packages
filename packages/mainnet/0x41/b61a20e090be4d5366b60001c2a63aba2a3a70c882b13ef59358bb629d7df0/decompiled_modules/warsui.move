module 0x41b61a20e090be4d5366b60001c2a63aba2a3a70c882b13ef59358bb629d7df0::warsui {
    struct WARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARSUI>(arg0, 6, b"WARSUI", b"NOWARSUI", x"506561636566756c20436f6d6d756e697479200a4e6f20746f20576172205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_6a9ffeb759.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

