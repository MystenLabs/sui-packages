module 0xb8d799208a44fa6511ad5388590c7a9d3651ccac1f39acd9683c4984871a1cbd::suid {
    struct SUID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUID>(arg0, 9, b"SUID", b"suidrop.com", b"Claim your SUI Ardrop now!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/sui-sui-logo.png?v=040")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUID>(&mut v2, 9999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUID>>(v1);
    }

    // decompiled from Move bytecode v6
}

