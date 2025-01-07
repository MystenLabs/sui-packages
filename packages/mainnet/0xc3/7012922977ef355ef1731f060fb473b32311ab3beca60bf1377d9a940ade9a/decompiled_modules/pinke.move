module 0xc37012922977ef355ef1731f060fb473b32311ab3beca60bf1377d9a940ade9a::pinke {
    struct PINKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKE>(arg0, 6, b"PINKE", b"Pinke On Sui", b"Pinke - which are rich asf and full of joy n fun brrr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008868_27c8115e90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

