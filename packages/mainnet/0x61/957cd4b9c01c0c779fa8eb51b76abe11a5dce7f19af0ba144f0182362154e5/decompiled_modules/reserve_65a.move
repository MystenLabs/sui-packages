module 0x61957cd4b9c01c0c779fa8eb51b76abe11a5dce7f19af0ba144f0182362154e5::reserve_65a {
    struct RESERVE_65A has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_65A>, arg1: 0x2::coin::Coin<RESERVE_65A>) {
        0x2::coin::burn<RESERVE_65A>(arg0, arg1);
    }

    fun init(arg0: RESERVE_65A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESERVE_65A>(arg0, 9, b"SEND", b"SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-Zlidl6Col2.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<RESERVE_65A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESERVE_65A>>(v1);
    }

    public fun module_hash() : u64 {
        4660
    }

    public fun process(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_65A>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RESERVE_65A> {
        0x2::coin::mint<RESERVE_65A>(arg0, arg1, arg2)
    }

    public entry fun process_to(arg0: &mut 0x2::coin::TreasuryCap<RESERVE_65A>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RESERVE_65A>>(0x2::coin::mint<RESERVE_65A>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

