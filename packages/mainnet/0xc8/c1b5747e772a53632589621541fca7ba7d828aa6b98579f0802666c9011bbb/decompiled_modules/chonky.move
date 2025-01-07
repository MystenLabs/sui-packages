module 0xc8c1b5747e772a53632589621541fca7ba7d828aa6b98579f0802666c9011bbb::chonky {
    struct CHONKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKY>(arg0, 9, b"CHONKY", b"Chonky", b"Chonky is a fun, oversized hippo mascot for Sui, representing strength, resilience, and laid-back confidence as it stomps through the crypto world with humor and charm.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1485393379966038017/JkvghU8V.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHONKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

