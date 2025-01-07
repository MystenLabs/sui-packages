module 0xccda2bb7b93abdd87776ca9840df7bd0eabc7953a9731c90a4eccd73a2ab3518::baloo {
    struct BALOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOO>(arg0, 6, b"Baloo", b"SuiBaloo", b"[$Baloo] Join this rebellion. and let's be the fucking masters in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241010_084606_575_be406faded.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

