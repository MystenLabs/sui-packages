module 0x4b34f60c40975b5ceeacabb0eb3706fcdcaa7eb028d5be5b1b06a652ddc43412::harry {
    struct HARRY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HARRY>, arg1: 0x2::coin::Coin<HARRY>) {
        0x2::coin::burn<HARRY>(arg0, arg1);
    }

    fun init(arg0: HARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARRY>(arg0, 9, b"SOY", b"HarryPotterObamaSonicDrakeInu69", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/0kryQLK.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HARRY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HARRY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

