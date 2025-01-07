module 0xd01522981d402f228888b085c3adf21d3568c3bdd282656914ead20a46461f5::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"Desteany", b"To the moon. HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/21c29640-e8bc-4a3c-8516-8c9e22eac135.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DES>>(v1);
    }

    // decompiled from Move bytecode v6
}

