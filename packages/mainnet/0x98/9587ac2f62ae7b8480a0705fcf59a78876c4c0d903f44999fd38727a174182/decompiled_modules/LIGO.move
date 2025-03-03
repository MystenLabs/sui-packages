module 0x989587ac2f62ae7b8480a0705fcf59a78876c4c0d903f44999fd38727a174182::LIGO {
    struct LIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGO>(arg0, 9, b"LIGO", b"LIGO", b"The biggest memecoin on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1726809766075543552/2FeguRUs_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LIGO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

