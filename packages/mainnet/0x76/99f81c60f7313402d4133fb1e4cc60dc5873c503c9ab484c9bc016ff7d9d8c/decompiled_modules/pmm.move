module 0x7699f81c60f7313402d4133fb1e4cc60dc5873c503c9ab484c9bc016ff7d9d8c::pmm {
    struct PMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMM>(arg0, 6, b"PMM", b"PatrickMahomes", b"Lets have fun and make money!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/My_Meme_d8ef302575.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

