module 0xf44d661998b2609f5e5e4849e9086ab408a04f8e2a96b4a3b37c8d7171183307::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 9, b"PUG", b"PugCoin", b"PugCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file.aiquickdraw.com/chatgpt/file-Pczzy7yDzp3dxoMn0fbYv8iW.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

