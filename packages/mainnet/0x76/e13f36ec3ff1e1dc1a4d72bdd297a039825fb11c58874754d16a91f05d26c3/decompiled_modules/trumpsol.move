module 0x76e13f36ec3ff1e1dc1a4d72bdd297a039825fb11c58874754d16a91f05d26c3::trumpsol {
    struct TRUMPSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPSOL>(arg0, 9, b"TRUMPSOL", b"TRUMP SOL", b"TRUMP WILL WIN THIS YEAR'S ELECTION, SUPPORT TRUMP WITH TRUMP TOKEN ON THE SOL SYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2b75657-1c47-4d7a-a7fa-131dd0f23e58.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

