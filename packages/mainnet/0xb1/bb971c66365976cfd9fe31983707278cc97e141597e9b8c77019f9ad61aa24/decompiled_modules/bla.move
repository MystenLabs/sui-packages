module 0xb1bb971c66365976cfd9fe31983707278cc97e141597e9b8c77019f9ad61aa24::bla {
    struct BLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLA>(arg0, 6, b"BLA", b"BLABLA", b"bla", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/random_5fba331692.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

