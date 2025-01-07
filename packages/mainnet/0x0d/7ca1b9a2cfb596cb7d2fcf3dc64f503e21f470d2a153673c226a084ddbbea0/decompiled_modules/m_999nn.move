module 0xd7ca1b9a2cfb596cb7d2fcf3dc64f503e21f470d2a153673c226a084ddbbea0::m_999nn {
    struct M_999NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: M_999NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M_999NN>(arg0, 9, b"M_999NN", b"meomelmeo", b"meo in the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8825e5b9-23fe-447f-9137-2b1b2a175116.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M_999NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M_999NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

