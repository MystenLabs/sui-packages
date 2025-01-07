module 0x5783b90be3d297a372b6111f46bae84652324a1a584fa10ced3b559e1910d37e::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 6, b"TOM", b"Farmer Tom", b"Meet Tom on $SUI ! He's not in the meme race, he's the smart one farming all the others!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008100_e9cfa40242.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

