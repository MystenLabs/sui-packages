module 0x6a76f979e2bfff44a11d42e953440b1e3aa05d358b380ed81914d2bcd2ab0b1b::piens {
    struct PIENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIENS>(arg0, 6, b"PIENS", b"SuiPiens", b"OG Community on $Sui Ecosystem. Share the news, strategy to build your wealth on@suinetwork O #BuildOnSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9577_051eb51af9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

