module 0x91b960ac76fdd8ba74e1acc81fe374c63e205f3e11b148ecf140c2e27df3b59d::o {
    struct O has drop {
        dummy_field: bool,
    }

    fun init(arg0: O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O>(arg0, 9, b"O", b"TDA", b"Bringing wealth to investors", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6f51ba2-c3af-4532-b663-b753aa5f0ec8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O>>(v1);
    }

    // decompiled from Move bytecode v6
}

