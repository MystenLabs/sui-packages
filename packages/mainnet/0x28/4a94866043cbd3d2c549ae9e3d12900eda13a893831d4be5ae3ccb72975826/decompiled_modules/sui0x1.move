module 0x284a94866043cbd3d2c549ae9e3d12900eda13a893831d4be5ae3ccb72975826::sui0x1 {
    struct SUI0X1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI0X1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI0X1>(arg0, 6, b"SUI0X1", b"SUIPlay0X1", b"$SUI is driving innovation in gaming, focusing on ownership and performance. With game developers building applications and the launch of the SuiPlay0X1 console, $SUI is pushing boundaries in both Web3 and Web2 gaming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiplay0x1_6cbc6094c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI0X1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI0X1>>(v1);
    }

    // decompiled from Move bytecode v6
}

