module 0x5b83089203b82e0c578cc615b7bbb2fc626f74df52207789682552fbf10e65eb::twif {
    struct TWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIF>(arg0, 9, b"TWIF", b"Trump Wif ", b"Trump Wif Hat Community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7aecd6a3-f3b9-4d82-b5bb-603924d4db58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

