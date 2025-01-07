module 0x521cba368ad791c606f6bbe40da6bd9f6e820a748611c722e51f4bbb27f4b708::suiii {
    struct SUIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIII>(arg0, 6, b"SUIII", b"SUIIICR7", b"SUIII is the ultimate meme coin for CR7 enthusiasts and Web3 degens alike. Inspired by the iconic spirit of Cristiano Ronaldo, SUIII aims to blend the passion of football with the energy of the blockchain community. Whether you're a fan of CR7s legendary goals or the thrill of trading in the SUI ecosystem, SUIII offers a space where sports meets crypto hype. Join the movement, and be part of the SUIII revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/51_H_Nur_J_Jcm_L_AC_UF_1000_1000_QL_80_72c48ba7ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

