module 0xa3e19d48084e9497895e33a0bf34fb8c62db92d364d2afa6442f27c2eb5f3943::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus", b"I'm going to keep posting about it until it becomes a real meme. l want tosee goatseus maximus posted on 4chan, l want to see it in the pornhubcomments,lwant to see it on tiktok.l want the goatse gospels to becrowdsourced and collectively understood by the crowd. I WILL NOTREST UNTIL GOATSEUS MAXIMUS IS MORE REAL THAN THE REALTHING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmap_Aq9_Wt_Nrtya_Dtj_ZPAHHN_Ymp_SZAQU_6_Hywwvf_S_Wq4d_QVV_4af67bfd6c.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

