module 0x2b469e848734994146be200cda816b22af9b480ebb707e584e1153e48cdca56b::peipei {
    struct PEIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEIPEI>(arg0, 6, b"Peipei", b"Peipei (SUI)", x"504549205045490a24504549504549207468652066726f672069732061207477697374206f6e204d617474204675726965732066616d6f75732050657065205468652046726f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pepe_clean_bg_removebg_preview_f371c3f95b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

