module 0xb1f033b4db64044dae5199ab13460c4332208a45a3d1d39f5cff320d7bfb3c88::ftb {
    struct FTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTB>(arg0, 6, b"FTB", b"Frog the blub", b"FROGTHEBLUB is inspired by the ferocious blub fish when in sui waters, we must fish and give to $FTB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042417_24a7b36582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTB>>(v1);
    }

    // decompiled from Move bytecode v6
}

