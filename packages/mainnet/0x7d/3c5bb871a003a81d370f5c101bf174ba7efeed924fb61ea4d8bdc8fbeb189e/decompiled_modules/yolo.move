module 0x7d3c5bb871a003a81d370f5c101bf174ba7efeed924fb61ea4d8bdc8fbeb189e::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"$YOLO", b"**Yolo Bot** is a fun, meme-powered crypto coin that embraces the \"You Only Live Once\" (YOLO) spirit. With its playful bot mascot, Yolo Bot encourages bold, carefree moves in the crypto world. It's all about having fun, taking risks, and riding the wave of internet culture. Perfect for meme lovers and adventurous crypto traders, Yolo Bot is here to bring excitement and humor to your wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736392828197_19aeb0db57_c457c9c314.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

