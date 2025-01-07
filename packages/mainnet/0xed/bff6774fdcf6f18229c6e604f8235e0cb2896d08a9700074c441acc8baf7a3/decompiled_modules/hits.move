module 0xedbff6774fdcf6f18229c6e604f8235e0cb2896d08a9700074c441acc8baf7a3::hits {
    struct HITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HITS>(arg0, 9, b"HITS", b"Hits", b"Sebuah token yang akan pump sangat hits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bba25200-ef8d-467f-a4f4-44fd0cf27657.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

