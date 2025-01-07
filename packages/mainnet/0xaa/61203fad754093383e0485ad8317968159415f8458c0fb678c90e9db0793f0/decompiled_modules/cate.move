module 0xaa61203fad754093383e0485ad8317968159415f8458c0fb678c90e9db0793f0::cate {
    struct CATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATE>(arg0, 6, b"CATE", b"$CATE on SUI", x"426f726e2066726f6d2020406f776e746865646f67650a2074776565742e2043617420627574207769746820616e20452e205368696e696e672062726967687420666f722024444f47452e2053554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cate_b837fb9142.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

