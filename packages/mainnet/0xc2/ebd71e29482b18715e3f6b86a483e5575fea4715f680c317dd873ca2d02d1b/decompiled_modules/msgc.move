module 0xc2ebd71e29482b18715e3f6b86a483e5575fea4715f680c317dd873ca2d02d1b::msgc {
    struct MSGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSGC>(arg0, 9, b"MSGC", b"Make Sui Greatest of Crypto", b"Make Sui Greatest of Crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSGC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSGC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

