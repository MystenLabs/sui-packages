module 0xfaeb5bc344b4ea0dc44c5c54f319ef4d87ede4da5fd8ad19fb63f746f162836f::suiborg {
    struct SUIBORG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBORG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIBORG>(arg0, 6, b"SUIBORG", b"Suiborg by SuiAI", b"Cybernetic dog-themed meme coin on Sui. NFTs, P2E, charity. Fair launch on MovePump. No rugs. Just moon missions!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/jkjjjhj_05491e115c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBORG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBORG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

