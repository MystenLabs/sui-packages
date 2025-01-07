module 0xd1d2198f56e6fbd68bbf6b9a879b04ed7eaff66ed8acb7a0c114d6c4d91c473c::bet {
    struct BET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BET>(arg0, 6, b"BET", b"Sui Bet", x"47616d626c696e672077697468696e20796f75722068616e6473210a0a57656c636f6d6520746f20537569426574202d20596f757220556c74696d6174652042657474696e672044657374696e6174696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suibet_e991744e50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BET>>(v1);
    }

    // decompiled from Move bytecode v6
}

