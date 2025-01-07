module 0xef86249863e85f090cbdc306e687247af6914a5dd70b45e5221c4282031ab192::cpo {
    struct CPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPO>(arg0, 9, b"CPO", b"capo", x"54686520617574686f72697461746976652063727970746f63757272656e637920746861742773206c656164696e672074686520636861726765207769746820706f77657266756c2070726f666974732c206f726368657374726174696e6720796f757220706f7274666f6c696f20746f2068697420616c6c20746865207269676874206e6f74657320e29895efb88fe29895efb88fe29895efb88fe29895efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52e3b1b5-8629-49c6-82ea-2a433812e7fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

