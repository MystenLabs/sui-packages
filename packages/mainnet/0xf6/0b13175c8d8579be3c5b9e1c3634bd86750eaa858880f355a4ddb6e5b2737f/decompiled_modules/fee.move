module 0xf60b13175c8d8579be3c5b9e1c3634bd86750eaa858880f355a4ddb6e5b2737f::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEE>(arg0, 6, b"FEE", b"FEE FISH", b"FEE FISH ON THE SUI OCEAN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A_Dx_Lk_JE_400x400_4ae530dcb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

