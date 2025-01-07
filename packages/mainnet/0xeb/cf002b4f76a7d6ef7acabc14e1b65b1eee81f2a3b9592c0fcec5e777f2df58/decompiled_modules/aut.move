module 0xebcf002b4f76a7d6ef7acabc14e1b65b1eee81f2a3b9592c0fcec5e777f2df58::aut {
    struct AUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUT>(arg0, 9, b"AUT", b"slightly autistic", b"$AUT - please be patient i have autism.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreiavhpn3kexwho6uaz23inpoha7j7tiis4gi7a6ie4zlguu2h4by6a.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AUT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

