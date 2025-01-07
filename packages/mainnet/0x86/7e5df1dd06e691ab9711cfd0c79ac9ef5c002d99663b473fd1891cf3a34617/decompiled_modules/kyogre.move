module 0x867e5df1dd06e691ab9711cfd0c79ac9ef5c002d99663b473fd1891cf3a34617::kyogre {
    struct KYOGRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYOGRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOGRE>(arg0, 9, b"KYOGRE", b"Kyogre", b"Kyogre is a ledendary pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f531950-2370-40ea-ac58-36456a03b32e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOGRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYOGRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

