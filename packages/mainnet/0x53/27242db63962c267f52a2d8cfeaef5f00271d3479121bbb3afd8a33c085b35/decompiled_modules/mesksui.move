module 0x5327242db63962c267f52a2d8cfeaef5f00271d3479121bbb3afd8a33c085b35::mesksui {
    struct MESKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MESKSUI>(arg0, 6, b"MeskSui", b"Enon mesk", b"This thirst leads Space X to space to find H2O", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmfQmJmnGipNkuqa6WcZxMNnD1RNRogViyszNJf48KU1uy?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MESKSUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MESKSUI>>(v2, @0x236aa176e48b5d14bcc28a674c1eb01ccde386f70f737346949577e0228e3f6f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MESKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

