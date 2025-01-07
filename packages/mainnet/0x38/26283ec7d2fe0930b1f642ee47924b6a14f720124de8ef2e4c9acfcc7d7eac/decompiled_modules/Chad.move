module 0x3826283ec7d2fe0930b1f642ee47924b6a14f720124de8ef2e4c9acfcc7d7eac::Chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHAD>, arg1: 0x2::coin::Coin<CHAD>) {
        0x2::coin::burn<CHAD>(arg0, arg1);
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<CHAD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAD>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"CHAD", b"Chadcoin is for Chads.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/2bF6gbY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

