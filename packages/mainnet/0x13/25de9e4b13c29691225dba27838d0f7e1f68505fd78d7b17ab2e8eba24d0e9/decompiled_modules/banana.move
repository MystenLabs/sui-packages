module 0x1325de9e4b13c29691225dba27838d0f7e1f68505fd78d7b17ab2e8eba24d0e9::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 9, b"BANANA", b"Just A Banana", b"The Original Banan On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqNvqlo-UqNGF5a4_RIUVD9EpsgojmsVPkFA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BANANA>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

