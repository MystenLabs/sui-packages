module 0x562fc47c5c419a37fe13d8a55e83ae00695eee1cd9a2f383659156dfcea49c19::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCH>(arg0, 9, b"WITCH", x"46554c4ce280a24d4f4f4e", b"A fun token for Taproot Witches ordinal lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c8d4ad8-baef-4f5f-b1ef-c420504e11b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

