module 0xb85d529b7cf62f5770fa89c7372d67abe67b5dc0d6a61cea9a719d00765b111d::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"ILLEGAL CRYPTO ENFORCEMENT", b"The Department of Illegal Crypto Enforcement is the official scam stopper of Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ice_logo_e85feb9d66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ICE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

