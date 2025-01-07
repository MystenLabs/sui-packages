module 0xed0cbe6b26eabb2846f4bbd01a38db8b91cfb2f5bbf5a804de8a1d2875c690ea::fpa {
    struct FPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPA>(arg0, 6, b"FPA", b"FUPA", b"Im bringing FUPA back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fupa_2_1ec4811e3f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

