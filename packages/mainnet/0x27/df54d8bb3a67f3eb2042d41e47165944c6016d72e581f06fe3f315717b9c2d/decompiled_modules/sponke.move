module 0x27df54d8bb3a67f3eb2042d41e47165944c6016d72e581f06fe3f315717b9c2d::sponke {
    struct SPONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONKE>(arg0, 6, b"SPONKE", b"SUIKE", x"4120646567656e65726174652067616d626c6572207468617420646f65736e742067657420616c6f6e672077697468206a75737420616e796f6e6520627574204920686176652061206c6f74206f6620667269656e64732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123754_fe26d8e233.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

