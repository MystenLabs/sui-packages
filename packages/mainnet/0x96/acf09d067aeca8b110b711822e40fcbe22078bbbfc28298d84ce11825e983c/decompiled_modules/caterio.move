module 0x96acf09d067aeca8b110b711822e40fcbe22078bbbfc28298d84ce11825e983c::caterio {
    struct CATERIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATERIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATERIO>(arg0, 6, b"CATERIO", b"Caterio", b"$CATERIO Is a meme token that merges the cunning wisdom of a cat with the loyal strength of the neiro token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_21_12_35_12_926c34c25d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATERIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATERIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

