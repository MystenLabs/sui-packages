module 0x58fd8f18a1ee9c2509431ca92a53b42b667955c7009ef81b39ff52df9990b3e5::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"Banana", b"Suiana", x"596f75207361696420617274203f0a6c6574732067726f77207468652062616e616e6120636f6d6d756e697479206f6e20746865206265737420626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Photoroom_20241214_182121_b4d310955d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

