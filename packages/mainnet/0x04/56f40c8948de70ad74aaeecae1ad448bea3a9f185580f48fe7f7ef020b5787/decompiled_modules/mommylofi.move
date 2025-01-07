module 0x456f40c8948de70ad74aaeecae1ad448bea3a9f185580f48fe7f7ef020b5787::mommylofi {
    struct MOMMYLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMMYLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMMYLOFI>(arg0, 6, b"Mommylofi", b"Mommy Lofi", b"The world of frozen era, Mommy Lofi is always here to protect her husband Lofi and her Baby Lofi. Join the LOFI Family movement", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735735466812.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMMYLOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMMYLOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

