module 0x2bf25a0e2f729dfbf37eb7ca6a437a10ada5870ab5996cbfd65a1ff06788299::wdb {
    struct WDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDB>(arg0, 6, b"WDB", b"$WalkingDinnerBoy", x"2057616c6b696e672044696e6e657220436f696e2069732074686520756c74696d61746520667573696f6e206f6620696e7465726e65742063756c7475726520616e642063727970746f63757272656e6379212044657369676e656420666f72207468652066756e2d6c6f76696e672c206d656d652d73686172696e6720636f6d6d756e6974792c206f757220636f696e2069736ee2809974206a75737420616e6f746865722063727970746fe280946974277320796f7572207469636b657420746f20616e2065636f73797374656d206f66206c61756768732c2063616d61726164657269652c20616e642066696e616e6369616c20706f74656e7469", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735791238411.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

