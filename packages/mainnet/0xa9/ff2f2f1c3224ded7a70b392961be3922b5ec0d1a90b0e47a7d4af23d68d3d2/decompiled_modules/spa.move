module 0xa9ff2f2f1c3224ded7a70b392961be3922b5ec0d1a90b0e47a7d4af23d68d3d2::spa {
    struct SPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPA>(arg0, 6, b"SPA", b"Scam Protect Agents", x"496e74726f647563696e672053504120436f696e3a0a5363616d2050726f74656374204167656e747320285350412920436f696e206973206e6f74206a75737420616e6f74686572206d656d6520636f696e0a2d20596f757220536869656c6420416761696e73742043727970746f205363616d730a2d2041205265766f6c7574696f6e61727920417070726f61636820746f205365637572652043727970746f63757272656e637920496e766573746d656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736011221772.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

