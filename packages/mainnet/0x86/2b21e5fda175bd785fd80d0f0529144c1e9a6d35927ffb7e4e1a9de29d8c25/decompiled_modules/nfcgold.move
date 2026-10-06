module 0x862b21e5fda175bd785fd80d0f0529144c1e9a6d35927ffb7e4e1a9de29d8c25::nfcgold {
    struct NFCGOLD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NFCGOLD>, arg1: 0x2::coin::Coin<NFCGOLD>) {
        0x2::coin::burn<NFCGOLD>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NFCGOLD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NFCGOLD>>(0x2::coin::mint<NFCGOLD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NFCGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFCGOLD>(arg0, 7, b"GOLD", b"GOLDNFC", b"GOLDNFC (GOLD) token on Sui. Buy, trade, and sell responsibly. COPYRIGHTS AND TRADEMARKS ALL PROPERTY OF THEIR RESPECTIVE OWNERS. COPYRIGHTS 2026-2096", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiex4elz3xsdq66glc74zb2tqft2byq34mbwoyzz7gcfd34k3acwke")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NFCGOLD>>(0x2::coin::mint<NFCGOLD>(&mut v2, 100000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFCGOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFCGOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

