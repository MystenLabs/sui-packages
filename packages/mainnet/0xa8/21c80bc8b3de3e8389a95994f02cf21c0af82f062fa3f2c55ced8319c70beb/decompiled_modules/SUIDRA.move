module 0xa821c80bc8b3de3e8389a95994f02cf21c0af82f062fa3f2c55ced8319c70beb::SUIDRA {
    struct SUIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRA>(arg0, 9, b"$SUIDRA", b"SUI Dragon", b"The biggest memecoin on SUI Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746721224041070592/gMxqMw7s_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDRA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIDRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

