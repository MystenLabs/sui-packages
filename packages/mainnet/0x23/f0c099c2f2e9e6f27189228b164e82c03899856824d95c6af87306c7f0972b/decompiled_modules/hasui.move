module 0x23f0c099c2f2e9e6f27189228b164e82c03899856824d95c6af87306c7f0972b::hasui {
    struct HASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUI>(arg0, 6, b"HASUI", b"Hasbulla Real", b"First Hasbulla On Sui.https://www.hasbullasui.pro | https://x.com/Hasbulla_Sui | https://t.me/HasbullaSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_logo_2_180x180_0472b37d22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

