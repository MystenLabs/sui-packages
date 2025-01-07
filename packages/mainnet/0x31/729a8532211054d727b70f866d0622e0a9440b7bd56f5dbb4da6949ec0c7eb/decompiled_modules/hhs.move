module 0x31729a8532211054d727b70f866d0622e0a9440b7bd56f5dbb4da6949ec0c7eb::hhs {
    struct HHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHS>(arg0, 6, b"HHS", b"HammerHead", x"54686520636f6f6c6573740a68616d6d6572686561640a6f6e20737569206f6365616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh81fm7_400x400_4c6368e77e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

