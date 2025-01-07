module 0xb242e012f66b79d4cbe60bcd2f569a999f46d536990133459dcb6d39a840b44b::fishui {
    struct FISHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHUI>(arg0, 9, b"FISHUI", b"FISHUI", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

