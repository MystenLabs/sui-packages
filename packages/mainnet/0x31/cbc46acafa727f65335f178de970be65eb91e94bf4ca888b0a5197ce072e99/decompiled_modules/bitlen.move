module 0x31cbc46acafa727f65335f178de970be65eb91e94bf4ca888b0a5197ce072e99::bitlen {
    struct BITLEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITLEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITLEN>(arg0, 6, b"Bitlen", b"Len Sassaman Tribute", b" Len Sassaman Tribute ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/461821888_502388216001725_2470532921476516817_n_9ff2449541.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITLEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITLEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

