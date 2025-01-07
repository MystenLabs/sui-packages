module 0x3d335e56d3def0feb9ee4cbf5c519486fd513f69f257fe606eecaee67f1377b::suitable {
    struct SUITABLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITABLE>, arg1: 0x2::coin::Coin<SUITABLE>) {
        0x2::coin::burn<SUITABLE>(arg0, arg1);
    }

    fun init(arg0: SUITABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITABLE>(arg0, 9, b"TABLE", b"SUITABLE", b"SUITABLE TG:https://t.me/tablesui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1745560370759032832/1jSbZLwY_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITABLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITABLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITABLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITABLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

