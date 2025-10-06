module 0x7c07c6e035f941ce1b1fd45ee847896f30aae00d3407b156f07f428b81973912::ika_fork {
    struct IKA_FORK has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<IKA_FORK>, arg1: 0x2::coin::Coin<IKA_FORK>) {
        0x2::coin::burn<IKA_FORK>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<IKA_FORK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IKA_FORK>(arg0, arg1, arg2, arg3);
    }

    public fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<IKA_FORK>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA_FORK>>(arg0, @0x0);
    }

    fun init(arg0: IKA_FORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKA_FORK>(arg0, 9, b"IFK", b"IKA Fork Token", b"A fork of IKA token for testing.", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKA_FORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<IKA_FORK>>(0x2::coin::mint<IKA_FORK>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA_FORK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun inku_per_ika_fork() : u64 {
        1000000000
    }

    // decompiled from Move bytecode v6
}

