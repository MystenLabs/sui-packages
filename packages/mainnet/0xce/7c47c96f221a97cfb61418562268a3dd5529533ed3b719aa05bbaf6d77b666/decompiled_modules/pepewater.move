module 0xce7c47c96f221a97cfb61418562268a3dd5529533ed3b719aa05bbaf6d77b666::pepewater {
    struct PEPEWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEWATER>(arg0, 6, b"PEPEWATER", b"Pepe In The Water", x"5065706520696e207468652077617465722e2052756c696e6720616c6c206d656d65636f696e73206173207468656972206b696e672e0a0a5065706520616c7761797320636f6e717565722065766572797468696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_07_31_12_638a12bf24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

