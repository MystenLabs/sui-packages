module 0x40a74ee4aa2d7dc9d3f19c03290d71e4ee27e21475d4180c3ea06c47d8cf37cd::shuiquan {
    struct SHUIQUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIQUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIQUAN>(arg0, 6, b"SHUIQUAN", b"Shui Quan", x"46697273742073756920636861696e20507265626f6e64656420427579626f74206973206c697665203b200a0a40536875695175616e427579426f740a0a0a68747470733a2f2f742e6d652f5375695175616e706f7274616c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027965_226e9d7e6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIQUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIQUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

