module 0x533572661b13a03850f668050f5c362a7d8cb79bb310b36670d11a346d8790b4::cekke {
    struct CEKKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEKKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEKKE>(arg0, 6, b"CEKKE", b"SUI CEKKE", b"CEKKE - the vibrant meme coin igniting SUI's ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jp4mhf_D8_400x400_5c71ab34a1_2af06a578b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEKKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEKKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

