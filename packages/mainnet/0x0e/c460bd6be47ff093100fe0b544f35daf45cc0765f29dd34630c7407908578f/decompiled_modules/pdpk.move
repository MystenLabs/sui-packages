module 0xec460bd6be47ff093100fe0b544f35daf45cc0765f29dd34630c7407908578f::pdpk {
    struct PDPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDPK>(arg0, 6, b"PDPK", b"Pudgy Pack", b" $PDPK is on a moon mission!  Our penguins got the bag, the rockets fueled, and were heading straight for the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019066_98281197e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

