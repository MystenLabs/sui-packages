module 0xbc7efaf3d524461872990a37120e11ff915299a72061b21cb4d12adf4cd0eeef::hoplum {
    struct HOPLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPLUM>(arg0, 6, b"HOPLUM", b"HOPlum", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d69736861707321200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_791aedba99_0fc760406e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

