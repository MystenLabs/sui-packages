module 0x1c264c3305369e787033e8389a615d1b9aa426fbe161abe6e84f6fc905ada1ae::zomp {
    struct ZOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOMP>(arg0, 6, b"ZOMP", b"ZOMBIE PUMP", b"The Undead Memecoin Pumping on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250120_094740_833948e31a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

