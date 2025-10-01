module 0x4f3f5fe7e8e87df5943c9991c751909f03f0392f9e38cd0d89a20a7974765424::tickleball {
    struct TICKLEBALL has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"$TB", b"TickleBall", b"When it tickles scratch it, that is how you tickle your balls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walrus.tusky.io/NVJ0wi9kg2xBSQVsbpbIIBWVHbEtXTBj5z_2a1rKSwo")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: TICKLEBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<TICKLEBALL>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKLEBALL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TICKLEBALL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TICKLEBALL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

