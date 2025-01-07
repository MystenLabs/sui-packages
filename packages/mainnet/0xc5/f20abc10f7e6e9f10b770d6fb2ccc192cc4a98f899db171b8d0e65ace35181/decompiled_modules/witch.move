module 0xc5f20abc10f7e6e9f10b770d6fb2ccc192cc4a98f899db171b8d0e65ace35181::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCH>(arg0, 6, b"WITCH", b"WITCHDOG SUI", b"Witch where the magic cryptocurrancy meets the spirit of advanture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001114_7606de885f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

