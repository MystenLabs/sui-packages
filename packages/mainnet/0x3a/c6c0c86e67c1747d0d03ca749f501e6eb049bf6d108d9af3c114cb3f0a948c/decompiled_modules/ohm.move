module 0x3ac6c0c86e67c1747d0d03ca749f501e6eb049bf6d108d9af3c114cb3f0a948c::ohm {
    struct OHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: OHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OHM>(arg0, 9, b"OHM", b"Hinduism ", b"Embark on a journey of spiritual exploration and self-discovery.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0696b39e-a987-475d-806c-63ed0f27a5da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

