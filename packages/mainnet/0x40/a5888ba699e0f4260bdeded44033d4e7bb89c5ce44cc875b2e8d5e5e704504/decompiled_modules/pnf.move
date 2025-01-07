module 0x40a5888ba699e0f4260bdeded44033d4e7bb89c5ce44cc875b2e8d5e5e704504::pnf {
    struct PNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNF>(arg0, 6, b"PNF", b"Phineas & Ferb", b"The Phineas and Ferb Fan Base Token is a unique, community-driven digital asset designed to celebrate and unite fans of the beloved animated series.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736265250192.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

