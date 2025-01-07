module 0x8b20330230d4740fcf281285004c5929e5109a010fafc36cc1bdd53e54699cd4::tct {
    struct TCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCT>(arg0, 9, b"TCT", b"TheChart", b"The Chart ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56d66617-5e71-4724-a737-677b7541e690-thechart.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

