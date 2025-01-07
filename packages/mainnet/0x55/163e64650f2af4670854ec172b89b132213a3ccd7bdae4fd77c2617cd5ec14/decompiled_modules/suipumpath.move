module 0x55163e64650f2af4670854ec172b89b132213a3ccd7bdae4fd77c2617cd5ec14::suipumpath {
    struct SUIPUMPATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPUMPATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPUMPATH>(arg0, 6, b"SUIPUMPATH", b"$SUIPUMPNEWATH", b"\"The performance of the Sui network is very good, and Sui pumped to a new all-time high. Sui pump refers to the increase in Sui's price. If you have Sui during the pump, your standard of living will always rise.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_suipump_056130179c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPUMPATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPUMPATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

