module 0x31cba647d22547c5b339f0c88a4b39ae25448361fe3b3a15e664cdb2517b98bb::supra {
    struct SUPRA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: 0x2::coin::Coin<SUPRA>) {
        0x2::coin::burn<SUPRA>(arg0, arg1);
    }

    fun init(arg0: SUPRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPRA>(arg0, 9, b"SUP", b"SUPRA", b"https://pbs.twimg.com/profile_images/1704143547769798656/W_J4MHEz_400x400.jpg", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUPRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUPRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

