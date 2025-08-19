module 0x805f94891d34b50aa47e728a685418569a9705a04c198702f339c7d770459300::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 9, b"son", b"son", b"Like farther Like son", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SON>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v2, @0xc0f6ee0569f6451a183672a4f651c59c73b85e8ea8e1d2fa1130778bea08b5c4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SON>>(v1);
    }

    // decompiled from Move bytecode v6
}

