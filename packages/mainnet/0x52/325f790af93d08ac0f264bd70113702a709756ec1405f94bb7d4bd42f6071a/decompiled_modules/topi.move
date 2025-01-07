module 0x52325f790af93d08ac0f264bd70113702a709756ec1405f94bb7d4bd42f6071a::topi {
    struct TOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPI>(arg0, 9, b"TOPI", b"TOPIUS", x"544f5049555320646f65736ee280997420636172652077686f20796f75206172652e204173206c6f6e6720617320796f752062757920746865206861742c20796f75e280997265206f6666696369616c6c7920612068617264636f72652066616e21204275742072656d656d6265722c20776561722074686174206861742074696768742c206265636175736520746865206d61726b657420697320616c7761797320726561647920746f207468726f7720796f7520696e746f207468652076616c6c6579e280a6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbd0771c-3851-4975-a86a-83c37c8ec8a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

