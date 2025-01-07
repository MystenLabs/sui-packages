module 0x818e9f1151ba9d33dac8dc0f2998f44d7ae9be4903f3e5bd0358bb0049e16c6f::er {
    struct ER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ER>(arg0, 9, b"ER", b"HJF", b"DHFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f5f8255-54a4-4e6d-a724-aa96b53487c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ER>>(v1);
    }

    // decompiled from Move bytecode v6
}

