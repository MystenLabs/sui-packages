module 0x71e9d59e392f8816dbb18160f7b08a7cccb003583d5b53000b24651e59c6cac3::duk {
    struct DUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUK>(arg0, 6, b"duk", b"duk", b"Hi, I'm duk on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/qJtYL10/ava-1.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

