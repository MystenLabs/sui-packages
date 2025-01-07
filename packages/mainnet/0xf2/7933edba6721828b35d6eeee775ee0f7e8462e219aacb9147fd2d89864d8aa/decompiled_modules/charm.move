module 0xf27933edba6721828b35d6eeee775ee0f7e8462e219aacb9147fd2d89864d8aa::charm {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARM>(arg0, 6, b"CHARM", b"Charmander", x"436861726d537569202d2024434841524d0a436861726d537569206973206120666972652d636861726765642063727970746f63757272656e6379206f6e207468652053554920626c6f636b636861696e2c20737061726b696e6720696e6e6f766174696f6e20616e6420656c65637472696679696e67207468652063727970746f20776f726c64210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038583_69d54571ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHARM>>(v1);
    }

    // decompiled from Move bytecode v6
}

