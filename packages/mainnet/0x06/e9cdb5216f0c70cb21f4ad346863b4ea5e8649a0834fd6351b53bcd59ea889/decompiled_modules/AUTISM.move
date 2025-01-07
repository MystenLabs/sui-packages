module 0x6e9cdb5216f0c70cb21f4ad346863b4ea5e8649a0834fd6351b53bcd59ea889::AUTISM {
    struct AUTISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISM>(arg0, 6, b"AUTISM", b"AUTISM", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/vvFEcpQ.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AUTISM>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

