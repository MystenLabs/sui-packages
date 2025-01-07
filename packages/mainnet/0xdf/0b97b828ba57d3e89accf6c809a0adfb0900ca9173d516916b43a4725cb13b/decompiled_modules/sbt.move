module 0xdf0b97b828ba57d3e89accf6c809a0adfb0900ca9173d516916b43a4725cb13b::sbt {
    struct SBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBT>(arg0, 6, b"SBT", b"Sui Baby Tiger", b"First Reflexive Meme Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_fa62446a4e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

