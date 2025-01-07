module 0x36f8cd61cf8d6511d533a5dfd5387d0dce3f890a5b51722ff5c24482636b4090::aaab {
    struct AAAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAB>(arg0, 6, b"AAAB", b"AAABIRD", b"screaming bird", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movpfp_f3de569d4f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

