module 0xf51cc6ebfe785a72a9901f748fae3267b2ba4142f4c8320c5b115f7b88b564a::shuiquan {
    struct SHUIQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIQUAN>(arg0, 6, b"SHUIQUAN", b"Shui Quan", x"46697273742073756920636861696e20507265626f6e64656420427579626f74206973206c697665200a0a40536875695175616e427579426f740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026539_507a4380f8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

