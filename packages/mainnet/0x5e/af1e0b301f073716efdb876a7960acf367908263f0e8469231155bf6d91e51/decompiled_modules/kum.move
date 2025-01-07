module 0x5eaf1e0b301f073716efdb876a7960acf367908263f0e8469231155bf6d91e51::kum {
    struct KUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUM>(arg0, 6, b"KUM", b"Kumala Harris", b"give it up for the one and only Kumala Harris", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4lww7r_4def8f2785.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

