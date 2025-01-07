module 0xc8e79914b33da6a91749b28e3c752754f20baa2b949ca8679a3b31460d1934de::awoo {
    struct AWOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWOO>(arg0, 9, b"AWOO", b"Awoo Cat", b"cats will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3173f2f-4502-4606-8597-351dc4c3ebaf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

