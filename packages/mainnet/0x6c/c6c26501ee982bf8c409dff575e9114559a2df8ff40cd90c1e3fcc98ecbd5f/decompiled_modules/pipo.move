module 0x6cc6c26501ee982bf8c409dff575e9114559a2df8ff40cd90c1e3fcc98ecbd5f::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"Pipo on sui", x"48692c20496d205069706f2e0a0a446f6e2774206c6574206d7920627261696e6c657373206661636520666f6f6c20796f752e0a49276d206865726520746f2065737461626c69736820686970706f706f74616d757320686567656d6f6e79206f7665722074686520656e746972652063727970746f20776f726c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040048_bef480fd48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

