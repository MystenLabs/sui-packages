module 0xb4ddfe405c140b5d981960e465758660efd5ed581cf49faa6867a1b93dfa2ee9::oly {
    struct OLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLY>(arg0, 9, b"OLY", b"Olympics", b"Game of heroes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54db8b32-a377-4850-9d25-645d3c876a62.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

