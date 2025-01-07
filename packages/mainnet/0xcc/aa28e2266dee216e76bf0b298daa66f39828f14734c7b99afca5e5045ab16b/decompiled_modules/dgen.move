module 0xccaa28e2266dee216e76bf0b298daa66f39828f14734c7b99afca5e5045ab16b::dgen {
    struct DGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGEN>(arg0, 6, b"DGEN", b"Degen The Otter", b"The world's first otter backed coin, officially supported by Degen's owner!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6233100314165232418_650e702d5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

