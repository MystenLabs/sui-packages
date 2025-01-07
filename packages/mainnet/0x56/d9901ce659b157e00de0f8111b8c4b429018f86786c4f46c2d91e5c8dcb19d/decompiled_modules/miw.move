module 0x56d9901ce659b157e00de0f8111b8c4b429018f86786c4f46c2d91e5c8dcb19d::miw {
    struct MIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIW>(arg0, 6, b"MIW", b"MIW On SUI", b"$MIW - MAKE IT WORK | Suicide Prev Token | Donating 10k per Mil mktcp | Ai Heath Coach", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/o7v0s_EFX_400x400_b90e4be9bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

