module 0x115dc0687ac6d5e6dd0851eb94489bc8f1c39332dfdea29d5817394f1e92b38::ppw {
    struct PPW has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPW>(arg0, 9, b"PPW", b"PepeWater", b"good water for good fren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/28/2c/dd/282cdd4401082f257c0354389f3c3856.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PPW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPW>>(v2, @0x7d80ef3c34ef8519515b57dfd7ca5ba32ebe4e27ef25e0d6683e8daafa0cefd9);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPW>>(v1);
    }

    // decompiled from Move bytecode v6
}

