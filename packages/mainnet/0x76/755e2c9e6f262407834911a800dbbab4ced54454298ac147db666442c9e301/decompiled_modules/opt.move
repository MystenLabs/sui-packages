module 0x76755e2c9e6f262407834911a800dbbab4ced54454298ac147db666442c9e301::opt {
    struct OPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPT>(arg0, 9, b"OPT", b"Optimistic", b"Always be optimistic and confident.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3f06bda-e46a-4b5c-bc50-6b474e1b9fcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

