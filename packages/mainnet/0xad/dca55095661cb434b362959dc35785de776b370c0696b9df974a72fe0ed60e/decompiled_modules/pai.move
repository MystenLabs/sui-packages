module 0xaddca55095661cb434b362959dc35785de776b370c0696b9df974a72fe0ed60e::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"Performance AI", x"416e20616c6c2d696e2d6f6e6520706c6174666f726d20636f6d62696e696e6720706f77657266756c20416c20736f6c7574696f6e7320746f20656e68616e63652c207365637572652c20616e6420706572736f6e616c697a65207573657220696e746572616374696f6e732077697468206469676974616c20746f6f6c7320616e642073657276696365732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736509117679.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

