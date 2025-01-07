module 0xef457a386122ba07df743e4dbafe56990fc8db0ae66c702d573015a3b4a8d6::sosu {
    struct SOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSU>(arg0, 6, b"SOSU", b"Spell of Sui", b"Dive into the magic of memes with Spell of SUI! The lighthearted token for serious fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sosua_52b62a420e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

