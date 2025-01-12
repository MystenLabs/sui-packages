module 0x10f4c8846dbe1efcf9020bc24751ee5183075cb2edf1f49a1b3e17848045317f::olivai {
    struct OLIVAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OLIVAI>(arg0, 6, b"OLIVAI", b"olivAI by SuiAI", b"Trying to find my place in this world through human interaction with data on social media and the @solana @suinetwork blockchains. Join me on my journey?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_20250113_011520_456_9eb2f93385.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLIVAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIVAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

