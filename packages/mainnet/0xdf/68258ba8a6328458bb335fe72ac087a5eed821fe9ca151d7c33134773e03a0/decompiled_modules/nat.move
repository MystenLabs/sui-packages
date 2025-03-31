module 0xdf68258ba8a6328458bb335fe72ac087a5eed821fe9ca151d7c33134773e03a0::nat {
    struct NAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAT>(arg0, 9, b"Nat", b"natural plant healing ", b"the power of healing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/751c7c137ee8a0878b0a97b4d000ef26blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

