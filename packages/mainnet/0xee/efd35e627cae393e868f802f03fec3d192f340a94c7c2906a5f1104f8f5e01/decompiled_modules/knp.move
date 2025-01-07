module 0xeeefd35e627cae393e868f802f03fec3d192f340a94c7c2906a5f1104f8f5e01::knp {
    struct KNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNP>(arg0, 9, b"KNP", b"Knopa", b"The best Dog in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49687ec5-1183-4562-9216-2a6caf909d73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

