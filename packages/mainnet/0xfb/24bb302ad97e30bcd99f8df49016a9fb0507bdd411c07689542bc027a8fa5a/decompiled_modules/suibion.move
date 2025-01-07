module 0xfb24bb302ad97e30bcd99f8df49016a9fb0507bdd411c07689542bc027a8fa5a::suibion {
    struct SUIBION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBION>(arg0, 6, b"Suibion", b"SUIBI", b"Dive into the deep waters of $SUIBI, every bubble is a gold coin on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_7bbe94fa69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBION>>(v1);
    }

    // decompiled from Move bytecode v6
}

