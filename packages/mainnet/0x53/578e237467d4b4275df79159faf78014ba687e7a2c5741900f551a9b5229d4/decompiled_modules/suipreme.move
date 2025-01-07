module 0x53578e237467d4b4275df79159faf78014ba687e7a2c5741900f551a9b5229d4::suipreme {
    struct SUIPREME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPREME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPREME>(arg0, 6, b"SUIPREME", b"SUIPREME the Supreme Sui Meme", x"5355495052454d45207468652053757072656d6520537569204d656d652e200a426f6e64696e6720666f7220627265616b666173742e204d6f6f6e696e6720666f722064696e6e65722e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030652_94c3b390cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPREME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPREME>>(v1);
    }

    // decompiled from Move bytecode v6
}

