module 0x4a22fc009e9e5e12531e553c2f1678c0563afc945db7461add79f267f4381d30::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST                              ", b"Test                                                              ", b"test                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iehrwufzbejutajyonqx.supabase.co/storage/v1/object/public/token-icons/32d3537b-0912-49d7-81a8-8965a9d74188.jpg                                                                                              ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

