module 0xab4cc820cc916eedefcc1f53b19f49dc3c4ee75c40c6e5bfa9bb3a26c402820e::bluedog {
    struct BLUEDOG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BLUEDOG>, arg1: 0x2::coin::Coin<BLUEDOG>) {
        0x2::coin::burn<BLUEDOG>(arg0, arg1);
    }

    fun init(arg0: BLUEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOG>(arg0, 9, b"blue dog", b"bluedog", b"https://x.com/BlueDogonSui https://t.me/BlueDogonSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/jWB6rVA.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEDOG>>(v1);
        0x2::coin::mint_and_transfer<BLUEDOG>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BLUEDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BLUEDOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

