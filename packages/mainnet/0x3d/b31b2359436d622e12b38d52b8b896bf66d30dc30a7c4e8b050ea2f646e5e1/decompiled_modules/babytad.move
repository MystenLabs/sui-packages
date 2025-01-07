module 0x3db31b2359436d622e12b38d52b8b896bf66d30dc30a7c4e8b050ea2f646e5e1::babytad {
    struct BABYTAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTAD>(arg0, 6, b"BABYTAD", b"Baby TAD", x"4261627920544144206f6e205355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_16_f7360d631e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

