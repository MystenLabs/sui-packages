module 0x5778455396ae6aa2828b9691651758a2b3520a072701f6f84cd49faeb01135fe::pepp {
    struct PEPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPP>(arg0, 9, b"PEPP", b"PEPPER", b"Spicy with $PEPP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35b0e3ae-2152-4315-bd04-09f85ab02102.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

