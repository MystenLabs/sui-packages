module 0x43a9bd4cd74f93e861b8a3138a373e726bb1f7bf8f4f38cde4872f0234ed20b::cece {
    struct CECE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CECE>, arg1: 0x2::coin::Coin<CECE>) {
        0x2::coin::burn<CECE>(arg0, arg1);
    }

    fun init(arg0: CECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CECE>(arg0, 6, b"CECE", b"CECE", b"being dex cece", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.beingdex.com/logo/cece.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CECE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CECE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CECE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CECE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

