module 0x1be52576ca90b480698903abaf5e3ad513c82da3694bc37ae7a46366de4bc91f::r245 {
    struct R245 has drop {
        dummy_field: bool,
    }

    fun init(arg0: R245, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R245>(arg0, 9, b"R245", b"Realtoken", b"COINS FOR TRADERS ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e9ba60b-18c2-453c-9f4b-b1c47c692fa3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<R245>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R245>>(v1);
    }

    // decompiled from Move bytecode v6
}

