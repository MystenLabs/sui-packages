module 0xfa00e2e3a089373de9d6d9d6808f9ac1faa585410a5b734ae3baa04aa5a9b932::wwee {
    struct WWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWEE>(arg0, 9, b"WWEE", b"Wewa", b"Dont but", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07688ec8-4309-4e90-8742-77929c67ef9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

