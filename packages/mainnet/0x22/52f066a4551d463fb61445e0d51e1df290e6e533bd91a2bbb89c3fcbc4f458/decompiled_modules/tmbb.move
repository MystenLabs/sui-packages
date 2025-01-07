module 0x2252f066a4551d463fb61445e0d51e1df290e6e533bd91a2bbb89c3fcbc4f458::tmbb {
    struct TMBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMBB>(arg0, 9, b"TMBB", b"Trust my boss bro", b"Trust my boss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/777b32ac5acb2315ee734a64e06517f0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMBB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMBB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

