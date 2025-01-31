module 0xed6dbdeca6e8bd15305ba98679a9ce269229b3ba33dbbfe3fa44de8556cd8b4a::farcana_token {
    struct FARCANA_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FARCANA_TOKEN>, arg1: 0x2::coin::Coin<FARCANA_TOKEN>) {
        0x2::coin::burn<FARCANA_TOKEN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FARCANA_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FARCANA_TOKEN>>(0x2::coin::mint<FARCANA_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FARCANA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARCANA_TOKEN>(arg0, 18, b"FAR", b"Farcana", b"Farcana Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/Vm89eJk8XWwZFm4IhybdkCtbeGAm5gRFNvG3JAXwSJY")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FARCANA_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARCANA_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

