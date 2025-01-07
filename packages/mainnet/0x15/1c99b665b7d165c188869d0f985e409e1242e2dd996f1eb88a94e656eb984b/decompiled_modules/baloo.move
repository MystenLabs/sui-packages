module 0x151c99b665b7d165c188869d0f985e409e1242e2dd996f1eb88a94e656eb984b::baloo {
    struct BALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOO>(arg0, 6, b"Baloo", b"SUIBALOO THE REBELLION", b"The rebellion has already arrived. baloo will end all the memes that get in his way ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_084606_575_4f704d987b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

