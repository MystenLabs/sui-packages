module 0x367b2cb04281cbc7fa932d677f75aeac68f9ded5e69a145bad31d3aca4a9c23b::xyysbb {
    struct XYYSBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: XYYSBB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XYYSBB>(arg0, 6, b"XYYSBB", b"Hxiisjs by SuiAI", b"Dhv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2573_9e198e4abd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XYYSBB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYYSBB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

