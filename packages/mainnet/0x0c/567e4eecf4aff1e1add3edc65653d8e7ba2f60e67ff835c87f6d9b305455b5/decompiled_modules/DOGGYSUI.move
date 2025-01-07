module 0xc567e4eecf4aff1e1add3edc65653d8e7ba2f60e67ff835c87f6d9b305455b5::DOGGYSUI {
    struct DOGGYSUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOGGYSUI>, arg1: 0x2::coin::Coin<DOGGYSUI>) {
        0x2::coin::burn<DOGGYSUI>(arg0, arg1);
    }

    fun init(arg0: DOGGYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGYSUI>(arg0, 6, b"DGS", b"DOGGYSUI", b"Bullfish captures the bullish spirit of the Sui network. It represents confidence in a future packed with opportunities. Jump in and ride the wave of growth with Bullfish! TG : https://t.me/DOGGYSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Qnsgxhj/DOGGYSUIsui.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGYSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGGYSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGGYSUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

