module 0xe2c44b7fe7bf783dda0f2e24ec9ae90f6aae6768c47c675ebc624fdd10e98c78::solcrusher {
    struct SOLCRUSHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLCRUSHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SOLCRUSHER>(arg0, 6, b"SOLCRUSHER", b"Sui Tooth", b"WE NEED TO BRING THE SULTAN OF SOLANA DOWN! THERE IS A NEW CLOWN IN TOWN AND WE'RE GONNA BRING THOSE SOLANA SOLDIERS TO THEIR KNEES WHEN THEY FACE THE SWEEEEEETEST OF ALL PHYSCOPATHS......THE SUI TOOTH!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui_tooth_1fb97ff2db.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOLCRUSHER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLCRUSHER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

