module 0xdeb61e5ce7e8c6ef0619e76339056dbf0dc82b9ee4b598393dadd185c209894a::mie {
    struct MIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIE>(arg0, 9, b"MIE", b"MiMi", b"my cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3692223c-12ad-4b65-b3fe-c8bbe6b3f8de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

