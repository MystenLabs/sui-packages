module 0x73204b18c99549c16c6540abde8d451a3071e979dff68ed45252bf3d9c6e34c3::tbb {
    struct TBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBB>(arg0, 6, b"TBB", b"Trump Behind Bars", b"**Trump Behind Bars ($TBB)** is the ultimate meme coin for those who want to call out the lies, scandals, and chaos of Donald J. Trump, the 45th and 47th President of the United States. While we all know Trumps unpredictability is a goldmine for the crypto economy, $TBB gives investors a unique space to vent, mock, and meme his most outrageous statements, actions, and legal troubles. Whether it's his ever-changing narratives, inflammatory rhetoric, or questionable business dealings, this token is a satirical protest wrapped in blockchain technology. Join the movement, trade the hype, and let your grievances be heard because in the crypto world, truth is as volatile as Trumps tweets!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aitubo_6134831e0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

