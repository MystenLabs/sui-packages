module 0x8d0a4c839edaedf0c60918431fc051e7a2f9a18b2587577f86c15a2e7e0bb8d3::ehs {
    struct EHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHS>(arg0, 9, b"EHS", b"Ehsan", b"ehsan token on the wawe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/652b19cf-283a-4cda-af50-2a3f81fbc47d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

