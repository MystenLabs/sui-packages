module 0x396b42eaac0301cf72ee414d5132a35b53f237131837bc9817900afb9d47b92d::whog {
    struct WHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOG>(arg0, 6, b"WHOG", b"Warthog", b" Warthhog Coin ($WHOG)  on $SUI| The wildest meme coin in the crypto jungle, built different, unstoppable, and charging to the moon. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PFP_ae82abe6f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

