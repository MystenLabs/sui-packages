module 0x5cbdc23307b90b87cc8d7a68417dc6eda8dd27ac69685c32f7fedf312b3ad2f::simba {
    struct SIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMBA>(arg0, 6, b"Simba", b"mufasa", b"Mufasa is a fictional character in Disney 's The Lion King franchise. A wise and benevolent lion, he first appears in the 1994 animated film as the King of the Pride Lands and devoted father to Simba, who he is raising to inherit the kingdom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mufasa_79e0aeee9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

