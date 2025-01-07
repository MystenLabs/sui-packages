module 0x56f6de8a3ffc4a3422b9c1fe2115f3904d2e02da0939447e2e5f0deb6178d152::SIMPSON {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SIMPSON>, arg1: 0x2::coin::Coin<SIMPSON>) {
        0x2::coin::burn<SIMPSON>(arg0, arg1);
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 2, b"Simpson", b"Simpson", b"Simpson on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0x44aad22afbb2606d7828ca1f8f9e5af00e779ae1.png?1683798501431")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SIMPSON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SIMPSON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

