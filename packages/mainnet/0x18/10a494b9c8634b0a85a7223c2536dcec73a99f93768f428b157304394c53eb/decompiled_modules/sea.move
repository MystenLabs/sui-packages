module 0x1810a494b9c8634b0a85a7223c2536dcec73a99f93768f428b157304394c53eb::sea {
    struct SEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEA>(arg0, 9, b"SEA", b"sea", b"wavy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d515945b-f18e-44d8-9343-58271991a881.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

