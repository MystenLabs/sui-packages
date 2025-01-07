module 0x46592e709ff27244e1f7bf532b4dba1c2855d56b68de1ab5c32396373b19ff13::mimi {
    struct MIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIMI>(arg0, 6, b"MIMI", b"Xiao Mimi", b"There's a small, very cute cat named Xiaomimi who is famous on TikTok. Its owner, Jessica, often shares videos and photos of Xiaomimi on her TikTok account @jessica12344901", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xiaomim_c9c311f21c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

