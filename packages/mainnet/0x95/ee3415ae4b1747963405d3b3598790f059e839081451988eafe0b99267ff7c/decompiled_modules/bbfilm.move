module 0x95ee3415ae4b1747963405d3b3598790f059e839081451988eafe0b99267ff7c::bbfilm {
    struct BBFILM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBFILM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBFILM>(arg0, 6, b"Bbfilm", b"Wedding Videographer", b"Steady is the name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737266339564.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBFILM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBFILM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

