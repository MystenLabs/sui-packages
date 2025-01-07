module 0x32da9c24f714a161338202491388aab0205abc417b811e9e3f1b63e0aa16bf71::gigabrain {
    struct GIGABRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGABRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGABRAIN>(arg0, 9, b"GIGABRAIN", b"Gigabrain coin", b"A coin to buy and hold, like a true gigabrain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://us-tuna-sounds-images.voicemod.net/2993e251-f7d3-4a2f-8d5f-23ca515ae9d8-1679615411944.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGABRAIN>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGABRAIN>>(v2, @0x1fbf68ab71d27cedc5e2f3890a72e531c6a9101128ce9c184a44fa3013e5dd8e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGABRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

