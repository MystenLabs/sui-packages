module 0xf7a30867f76214a46825c633552f2522440ae03ca5559831853ed3e740c47618::kdt67yuk {
    struct KDT67YUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDT67YUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDT67YUK>(arg0, 9, b"KDT67YUK", b"kdyuk", b"fhi;l", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5357aafeb97ffa551ebab48a23647655blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDT67YUK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDT67YUK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

