module 0x85d9d2ee70621ffbb702c3837ecfd064c919dcf85113e1d8c30c3d98e0ef0c5c::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 9, b"P", b"DCat", b"Cats and dogs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/86eeb32d-66af-4acc-8ef2-77f0e0e04a53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

