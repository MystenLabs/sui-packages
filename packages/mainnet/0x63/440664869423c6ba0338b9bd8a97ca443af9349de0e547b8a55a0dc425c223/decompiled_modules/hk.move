module 0x63440664869423c6ba0338b9bd8a97ca443af9349de0e547b8a55a0dc425c223::hk {
    struct HK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HK>(arg0, 9, b"HK", b"Happy Kids", b"Happy Kids dancing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e1d634984a558c159155031173e7a205blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

