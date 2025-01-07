module 0x8d5684a065e5ffe318311a2fff785ce386c2b22f4e9c953d52ed113df09d3b01::here {
    struct HERE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HERE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HERE>(arg0, 6, b"HERE", b"THEYAREHERE", b"THEY ARE ABOVE MY HOUSE. PROBING IMMINENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734095930451.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HERE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HERE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

