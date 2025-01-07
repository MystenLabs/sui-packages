module 0x872f647acb6730b30fce956fdd376c84f86d6a202bfc99927c24ef1de1920813::somis_token {
    struct SOMIS_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SOMIS_TOKEN>, arg1: 0x2::coin::Coin<SOMIS_TOKEN>) {
        0x2::coin::burn<SOMIS_TOKEN>(arg0, arg1);
    }

    fun init(arg0: SOMIS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMIS_TOKEN>(arg0, 9, b"SOMIS", b"SOMIS", b"Somis Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdRhHA5CFRafncecT4kLYLeV6duYJVbc73XnKasUNpb19")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOMIS_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMIS_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOMIS_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOMIS_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

