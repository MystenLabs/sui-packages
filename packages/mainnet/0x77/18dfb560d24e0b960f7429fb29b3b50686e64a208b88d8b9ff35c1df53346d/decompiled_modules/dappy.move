module 0x7718dfb560d24e0b960f7429fb29b3b50686e64a208b88d8b9ff35c1df53346d::dappy {
    struct DAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAPPY>(arg0, 6, b"DAPPY", b"First Dappy On Sui", b"First Dappy On Sui : https://www.dappy-sui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_2_ea097408f3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

