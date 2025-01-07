module 0xb0df4b294730f83a30077dcadfc5952832fdce1685670c42d269914fd2b098d5::wbonk {
    struct WBONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBONK>(arg0, 9, b"WBONK", b"Bonk Wave", b"Bonk Wave combines the viral energy of Bonk with the Sui blockchain's fast and efficient infrastructure. Designed to ride the memecoin craze, it offers seamless, low-cost transactions powered by Sui's cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1677344899136454658/okp3qjAF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WBONK>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBONK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

