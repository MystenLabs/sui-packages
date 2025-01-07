module 0x8aa1794ebef7d8bf951778dba098dab71576cdb94944a8b5bff5ce93bec4fa64::suiurchin {
    struct SUIURCHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIURCHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIURCHIN>(arg0, 6, b"SUIURCHIN", b"SUI URCHIN", x"546865206375746573742c20627574207370696b792075726368696e206f66205375692069732068657265210a0a4f66666572696e6720612064656c65637461626c652079756d6d7920746173746520746f206665656420646567656e7320616e6420636861647320616c696b65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_19_00_20_1d583aa1c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIURCHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIURCHIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

