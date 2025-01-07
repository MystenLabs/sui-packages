module 0x364821c4aad86761212e0f33d5dc9d0a7783d9637e02463c8b5e210508041f8e::fry {
    struct FRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRY>(arg0, 6, b"FRY", b"Fry On Sui", x"5769746820796f75722068656c702077652063616e206265206f6e65206f6620746865206265737420636f6d6d756e6974696573206f6e20537569210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048555_29df95d498.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

