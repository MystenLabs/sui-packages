module 0xb80ffdca15bf0fc1ffce90292e74940d1080ec78ea5958a99a27f68a06a6588e::suidrugs {
    struct SUIDRUGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRUGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRUGS>(arg0, 6, b"SUIDRUGS", b"Sui Drugs", x"4e6f776164617973207765206b6e6f772074686174206472556773206172652074616b696e67206f766572206f757220796f756e672070656f706c652c20636f6d6520616e642062652070617274206f662074686973206772656174206d6f6d656e74210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_11_T095855_146_64013d2060.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRUGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRUGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

