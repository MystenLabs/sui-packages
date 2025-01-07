module 0xe24cfe9b69347d101e077351d1ca1de1967ab1dce1f02bc882e1881d7c026310::whalo {
    struct WHALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALO>(arg0, 6, b"WHALO", b"King Whalo", b"Community driven token for the king of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chris_1c6aaefe9b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

