module 0xae8be613ab2e19dd22bc9d9613b3d0d21c5494265cf3b4616cbf9047193bf02f::elon_3 {
    struct ELON_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON_3>(arg0, 9, b"ELON_3", b"BAYBEELON", b"son of elonmuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56c45e98-96f7-4f07-81cd-2a89cb4ed478.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON_3>>(v1);
    }

    // decompiled from Move bytecode v6
}

