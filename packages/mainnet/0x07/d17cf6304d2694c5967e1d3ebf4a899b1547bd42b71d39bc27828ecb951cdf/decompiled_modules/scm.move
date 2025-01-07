module 0x7d17cf6304d2694c5967e1d3ebf4a899b1547bd42b71d39bc27828ecb951cdf::scm {
    struct SCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCM>(arg0, 6, b"SCM", b"SUICAT MEME", b"Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736072101954.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

