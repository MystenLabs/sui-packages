module 0x4dae676c9d3027b4c63e262966317c033e5d18e3b1a5177f762dfec0eb349e2::ibysui {
    struct IBYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBYSUI>(arg0, 9, b"IBYSUI", b"IBYSUI ", b"IBYSUI is a unique digital token designed to facilitate seamless transactions and interactions within a decentralized network. It fuels a robust ecosystem, enabling users to participate in various activities,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c6fb7cf-d8da-432b-9c6c-454e15ba0f1b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IBYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

