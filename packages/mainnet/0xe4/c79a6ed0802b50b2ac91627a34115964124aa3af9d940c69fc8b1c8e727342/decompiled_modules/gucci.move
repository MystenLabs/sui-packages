module 0xe4c79a6ed0802b50b2ac91627a34115964124aa3af9d940c69fc8b1c8e727342::gucci {
    struct GUCCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUCCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUCCI>(arg0, 9, b"GUCCI", b"GUCCI", b"Gucci Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUCCI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUCCI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUCCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

