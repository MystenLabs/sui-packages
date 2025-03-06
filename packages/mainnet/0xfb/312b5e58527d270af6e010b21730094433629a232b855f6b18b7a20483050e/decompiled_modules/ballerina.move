module 0xfb312b5e58527d270af6e010b21730094433629a232b855f6b18b7a20483050e::ballerina {
    struct BALLERINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLERINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLERINA>(arg0, 9, b"BALLERINA", b"BALLERINA", b"The world of John Wick expands with BALLERINA, as Ana de Armas stars as an assassin trained in the traditions of the Ruska Roma.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/BALLERINA.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BALLERINA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLERINA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLERINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

