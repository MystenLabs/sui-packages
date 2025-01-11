module 0x716742ba90a0822a2f5bbc569523cc1b718d3c62ae6697e2452e17890bbb57db::eas {
    struct EAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAS>(arg0, 9, b"EAS", b"EASports Tsenegame", x"f09f9a802045412053706f727473205473656e6567616d6520f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/HGmjfCP/fond-ballon-football-futuriste-illustration-conception-3d-ballon-football-ai-generative-555028-191-m.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EAS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

