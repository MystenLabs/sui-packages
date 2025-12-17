module 0x8b8b004e9f20baef475d4468a05e96ff46047b9feac71480da8d75871e619a06::tsb_mj9ezhrv21fb {
    struct TSB_MJ9EZHRV21FB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSB_MJ9EZHRV21FB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSB_MJ9EZHRV21FB>(arg0, 9, b"TSB", b"TESTING BONDING", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmekajsUio7j3u1iQXQFdb15kqLsWwKwFyjP6mYNZkXqcb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSB_MJ9EZHRV21FB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSB_MJ9EZHRV21FB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

