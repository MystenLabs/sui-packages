module 0xd5aadd047623d19ec506cdcb093647087afd93454d7992300dab807f42b490d4::rhode {
    struct RHODE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<RHODE>, arg1: 0x2::coin::Coin<RHODE>) {
        0x2::coin::burn<RHODE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RHODE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RHODE>>(0x2::coin::mint<RHODE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RHODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHODE>(arg0, 9, b"rhode", b"RHODE", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

