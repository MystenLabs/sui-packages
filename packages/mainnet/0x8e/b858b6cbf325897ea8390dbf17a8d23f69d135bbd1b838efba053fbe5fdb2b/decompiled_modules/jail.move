module 0x8eb858b6cbf325897ea8390dbf17a8d23f69d135bbd1b838efba053fbe5fdb2b::jail {
    struct JAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAIL>(arg0, 6, b"Jail", b"Hayden", b"Jail Hayden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003309_927c222924.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

