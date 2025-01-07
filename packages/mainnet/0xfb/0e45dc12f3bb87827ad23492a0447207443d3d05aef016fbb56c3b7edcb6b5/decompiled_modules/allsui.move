module 0xfb0e45dc12f3bb87827ad23492a0447207443d3d05aef016fbb56c3b7edcb6b5::allsui {
    struct ALLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLSUI>(arg0, 9, b"ALLSUI", b"All Sui ", b"Just to buy and Sell ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77bbc885-aa81-4683-90a8-87a7bbae1e9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

