module 0xdd911d422a60d83c4889304325d3eefe998775fe559b4d782848709a4e6ec9d5::n1ck69 {
    struct N1CK69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N1CK69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N1CK69>(arg0, 9, b"N1CK69", b"N1CK", b"THE N1CK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d581dbf2-7802-4b64-94f3-58b0efd53747.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N1CK69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N1CK69>>(v1);
    }

    // decompiled from Move bytecode v6
}

