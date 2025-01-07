module 0xf6e3d8d9755b6323aac704a70c18c920dc9ebe58364cc9321078f36a0d5949ab::asui {
    struct ASUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ASUI>, arg1: 0x2::coin::Coin<ASUI>) {
        0x2::coin::burn<ASUI>(arg0, arg1);
    }

    fun init(arg0: ASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASUI>(arg0, 9, b"asui", b"asui", b"THE FIRST SUI-DERIVATIVE ON THE SUI BLOCKCHAIN. $ASUI https://t.me/+ebBW0FrOCrk5ZTk1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/NAauvyu.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASUI>>(v1);
        0x2::coin::mint_and_transfer<ASUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ASUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

