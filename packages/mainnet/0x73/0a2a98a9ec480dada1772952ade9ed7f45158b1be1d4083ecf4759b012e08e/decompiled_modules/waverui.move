module 0x730a2a98a9ec480dada1772952ade9ed7f45158b1be1d4083ecf4759b012e08e::waverui {
    struct WAVERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVERUI>(arg0, 9, b"WAVERUI", b"Rui", b"A growing platform", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5949d75f-3f8c-474a-9f36-48994ed5a508.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVERUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVERUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

