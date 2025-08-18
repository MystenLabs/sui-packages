module 0x4435c16a43e7a31480cf61f89c1b1920cb492941e614f3b2d8180b9e552ec180::never {
    struct NEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEVER>(arg0, 9, b"NEVER", b"Never like it", b"https://x.com/0xrooter/status/1957463473534980457", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEVER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEVER>>(v2, @0x5176cc545c5a2974b427402a2512715bb8270289262e494831c31cab4930f0df);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

