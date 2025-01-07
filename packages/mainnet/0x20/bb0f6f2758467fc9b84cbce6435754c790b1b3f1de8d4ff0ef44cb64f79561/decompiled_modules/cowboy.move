module 0x20bb0f6f2758467fc9b84cbce6435754c790b1b3f1de8d4ff0ef44cb64f79561::cowboy {
    struct COWBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWBOY>(arg0, 9, b"COWBOY", b"Cowboy Inu", b"I started The Dog Cowboy as an alternative to leaving your dog at a day care all day. By giving your dog a physical and mental workout they are happy and sleepy. This lets you get on with the things you want and need to do without your best friend getting under your feet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/Jht4Rs4.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COWBOY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWBOY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COWBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

