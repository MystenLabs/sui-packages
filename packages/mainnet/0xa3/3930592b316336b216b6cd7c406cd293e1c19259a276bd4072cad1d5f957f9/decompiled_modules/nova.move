module 0xa33930592b316336b216b6cd7c406cd293e1c19259a276bd4072cad1d5f957f9::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 9, b"Nova", b"Nova Network", b"Nova Just a Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775389055192-ee2f1e468ae3e76319ecb30a8a102e34.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<NOVA>>(0x2::coin::mint<NOVA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

