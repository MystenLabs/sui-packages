module 0xb9abaec18254d541da1b271c89ea0e5324319af998e0d0ebf93e3a106044e831::elt {
    struct ELT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELT>(arg0, 9, b"ELT", b"El Trump", b" EL TRUMP TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6ca8d64-ff61-4366-ba26-a4b80b82d308.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELT>>(v1);
    }

    // decompiled from Move bytecode v6
}

