module 0xd49642a1b22f8163534202b296b973964289db3716b7e54d693da7498b8f4533::bedft {
    struct BEDFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEDFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEDFT>(arg0, 9, b"BEDFT", b"Bedtime Fun Token", b"A token for all things fun and relaxing before bedtime.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEDFT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEDFT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEDFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

