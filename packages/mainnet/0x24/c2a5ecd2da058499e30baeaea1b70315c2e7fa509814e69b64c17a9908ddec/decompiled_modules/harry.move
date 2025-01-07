module 0x24c2a5ecd2da058499e30baeaea1b70315c2e7fa509814e69b64c17a9908ddec::harry {
    struct HARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRY>(arg0, 9, b"HARRY", b"Harrywiflambo", b"Harrywiflambo is a fun, community-driven token on the SUI blockchain, offering fast, secure, and scalable transactions. It combines innovation and excitement to power a vibrant DeFi ecosystem, making blockchain interactions engaging and efficient.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1843740238616616960/EeGM64q1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HARRY>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

