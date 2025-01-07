module 0xb89fb21babf2182194bc093705a3685601e3c03073019b6d088c2efdb287f39f::suity {
    struct SUITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITY>(arg0, 6, b"SUITY", b"SUITY!", b"With a sweet tooth for profits, Suity is the playful cat who prowls the Sui network in search of delicious opportunities. Just like a perfect donut, Suity knows exactly where the sweetest gains are hiding. With sharp instincts and a knack for sniffing out market trends, Suity guides you through the blockchain with ease, always pouncing on the next big", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_14_10_05_57_02d26f5f0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITY>>(v1);
    }

    // decompiled from Move bytecode v6
}

