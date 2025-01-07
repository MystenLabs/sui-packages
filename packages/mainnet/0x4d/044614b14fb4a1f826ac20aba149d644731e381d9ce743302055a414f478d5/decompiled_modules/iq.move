module 0x4d044614b14fb4a1f826ac20aba149d644731e381d9ce743302055a414f478d5::iq {
    struct IQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IQ>(arg0, 6, b"IQ", b"IQ Check", b"Think youre the smartest on ? Let AI  decide  check your IQ now!  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_A_Ol_Sd_ZW_400x400_ec3c803ebd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

