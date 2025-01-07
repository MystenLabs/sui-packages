module 0x48812952c37afee557acfc797f2146857774109d66ef1a783664879653724c08::mona {
    struct MONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONA>(arg0, 6, b"MONA", b"MONAONSUI", b"MONA ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vnck1_I_Aj_400x400_0c87ebe4d5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

