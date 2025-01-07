module 0xafb0eaae1e36d56821355441b93aeb507e4e016552fbbcb8ea9f79128f97e624::sfish {
    struct SFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFISH>(arg0, 6, b"SFISH", b"STAR FISH", b"Once upon a time, there was a starfish living in the depths of the ocean. One day, it washed ashore and couldn't return to the sea on its own. Other sea creatures quickly came to help it. The other creatures joined in, and together they tossed the starfish back into the water. This experience taught the starfish that small acts of help can make a big difference.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OW_8_MX_Ciy_400x400_96a119874b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

