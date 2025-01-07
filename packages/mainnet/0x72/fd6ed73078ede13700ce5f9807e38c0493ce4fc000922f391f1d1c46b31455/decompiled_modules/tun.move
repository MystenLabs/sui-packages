module 0x72fd6ed73078ede13700ce5f9807e38c0493ce4fc000922f391f1d1c46b31455::tun {
    struct TUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUN>(arg0, 9, b"TUN", b"TUNA", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/68fe6a96-f806-49eb-988c-caa9760472d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

