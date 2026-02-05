module 0x23da76c00883b8e911ef7382818f6ad745a6aca1f2ea823bb517a7fd47cebe66::jackymarch {
    struct JACKYMARCH has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JACKYMARCH>, arg1: 0x2::coin::Coin<JACKYMARCH>) {
        0x2::coin::burn<JACKYMARCH>(arg0, arg1);
    }

    fun init(arg0: JACKYMARCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKYMARCH>(arg0, 6, b"jackymarch", b"jackymarch", b"Personal AI assistant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fDVEyJV.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JACKYMARCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKYMARCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JACKYMARCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JACKYMARCH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

