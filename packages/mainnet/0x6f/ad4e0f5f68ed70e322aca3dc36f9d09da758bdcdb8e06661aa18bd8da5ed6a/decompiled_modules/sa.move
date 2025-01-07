module 0x6fad4e0f5f68ed70e322aca3dc36f9d09da758bdcdb8e06661aa18bd8da5ed6a::sa {
    struct SA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SA>(arg0, 18, b"SA", b"SA", b"sahab's token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/162699534")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

