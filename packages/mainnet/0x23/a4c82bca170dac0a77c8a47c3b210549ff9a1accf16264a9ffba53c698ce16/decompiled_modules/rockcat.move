module 0x23a4c82bca170dac0a77c8a47c3b210549ff9a1accf16264a9ffba53c698ce16::rockcat {
    struct ROCKCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKCAT>(arg0, 6, b"RockCat", b"Rocket Cat", b"A cat sent to the sky by a rocket ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_2024_10_14_19_26_55_50313b8f55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

