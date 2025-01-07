module 0xc461cd3f242e46fc0070807463300e094247a746a8a1fd4d2df1bf989bfd21e::nyxc {
    struct NYXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYXC>(arg0, 6, b"NYXC", b"Nyxia Coin", b"Project Nyxia is the Spiritual Layer of AI and as such builds applications (Layer 2) and products (Layer 3) on AI, all based around the magic feline representation Nyxia and Nyxia's Brand Promise rooted upon positivity, arts and spirituality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NYXIA_ca9232c0b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYXC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYXC>>(v1);
    }

    // decompiled from Move bytecode v6
}

