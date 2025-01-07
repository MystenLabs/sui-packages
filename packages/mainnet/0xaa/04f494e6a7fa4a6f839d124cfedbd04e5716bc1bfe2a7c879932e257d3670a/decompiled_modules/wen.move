module 0xaa04f494e6a7fa4a6f839d124cfedbd04e5716bc1bfe2a7c879932e257d3670a::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 6, b"WEN", b"Wen moon", b"WENmoon is a vibrant meme project inspired by the fan base of WEN on solana with focus on community Decentralization and we aim to foster a lively an exclusive ecosystem where everyone has a voice", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076194_f947c85af5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

