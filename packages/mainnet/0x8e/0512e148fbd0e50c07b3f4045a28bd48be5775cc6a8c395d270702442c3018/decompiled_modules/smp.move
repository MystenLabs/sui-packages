module 0x8e0512e148fbd0e50c07b3f4045a28bd48be5775cc6a8c395d270702442c3018::smp {
    struct SMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMP>(arg0, 6, b"SMP", b"SuiMemeParty", b"SUIMEMEPARTY is not just another cryptocurrency  it's a movement, a community, and maybe even a lifestyle! Born from the depths of internet culture, our coin aims to bring laughter, fun, and gains to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000503_cd08a94b1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

