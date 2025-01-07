module 0x4eaec948d718fa838552c48dd96efb801fb7813fa361b1437c1c1f22caec1070::peesui {
    struct PEESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEESUI>(arg0, 6, b"PEESUI", b"PEPE SUI", b"PEEEEEEEEEEEEEEEEEE PEEEEEEEEEEEEEEEEEEEEE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PEPESUI_8cd750e5ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

