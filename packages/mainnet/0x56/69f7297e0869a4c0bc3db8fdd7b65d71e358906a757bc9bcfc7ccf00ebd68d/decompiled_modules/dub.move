module 0x5669f7297e0869a4c0bc3db8fdd7b65d71e358906a757bc9bcfc7ccf00ebd68d::dub {
    struct DUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUB>(arg0, 6, b"dub", b"Duby", b"Duby on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://strapi-dev.scand.app/uploads/sui_c07df05f00.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

