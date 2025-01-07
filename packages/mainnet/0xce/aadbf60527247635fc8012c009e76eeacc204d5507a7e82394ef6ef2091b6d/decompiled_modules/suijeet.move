module 0xceaadbf60527247635fc8012c009e76eeacc204d5507a7e82394ef6ef2091b6d::suijeet {
    struct SUIJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJEET>(arg0, 6, b"SUIJEET", b"Pranav Suijeet", b"buttaar chickannn plizeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIJEET_75c284d74a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJEET>>(v1);
    }

    // decompiled from Move bytecode v6
}

