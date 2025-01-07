module 0x14c6ee59fc5242594eec23f3c35da0eda2b69ebb4e098ce294ebad54e4848563::alex {
    struct ALEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALEX>(arg0, 6, b"ALEX", b"Alex on SUI", b"Im Alex. A degen who lost it all. Now i hide my face with a bag in shame. But the jobs not finished, i will be back, i will make it, were all gonna make it. Time to win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3a_b22baca3e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

