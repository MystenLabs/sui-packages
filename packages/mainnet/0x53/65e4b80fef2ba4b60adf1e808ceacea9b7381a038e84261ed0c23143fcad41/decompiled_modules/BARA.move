module 0x5365e4b80fef2ba4b60adf1e808ceacea9b7381a038e84261ed0c23143fcad41::BARA {
    struct BARA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BARA>, arg1: 0x2::coin::Coin<BARA>) {
        0x2::coin::burn<BARA>(arg0, arg1);
    }

    fun init(arg0: BARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARA>(arg0, 2, b"BARA", b"BARA", b"BARA on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xf190dbd849e372ff824e631a1fdf199f38358bcf.png?1684093384498")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BARA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BARA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

