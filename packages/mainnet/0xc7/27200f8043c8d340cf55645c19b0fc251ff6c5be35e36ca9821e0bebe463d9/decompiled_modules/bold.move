module 0xc727200f8043c8d340cf55645c19b0fc251ff6c5be35e36ca9821e0bebe463d9::bold {
    struct BOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLD>(arg0, 6, b"BOLD", b"Sui Bold", b"Pepe has a son and his name is BOLD because he always does bold moves like us degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiba4hop2vpc74wrizqqtvh7obhwygfdcep2chmgu6pqww6iv3baiy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

