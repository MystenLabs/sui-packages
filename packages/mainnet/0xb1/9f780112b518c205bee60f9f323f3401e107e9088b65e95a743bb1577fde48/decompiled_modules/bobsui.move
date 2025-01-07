module 0xb19f780112b518c205bee60f9f323f3401e107e9088b65e95a743bb1577fde48::bobsui {
    struct BOBSUI has drop {
        dummy_field: bool,
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<BOBSUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: BOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBSUI>(arg0, 6, b"BOBSUI", b"BOBSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/T7etzYT.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBSUI>>(v0, @0x73817290337026d17215b5848c0309e0319b978c87b323b405853c0283be837e);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<BOBSUI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOBSUI>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

