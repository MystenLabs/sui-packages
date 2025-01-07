module 0xa51b40ec195433681b76fe527ecbdc0b94c7f6c7917b9d60f9d10c9b25fa7d08::sn {
    struct SN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SN>(arg0, 6, b"SN", b"SuiNoise", b"is a meme coin based on the Sui blockchain, which symbolizes everything related to crypto noise and hype. The name reflects the ironic essence of the coin: the hype around cryptocurrencies, which often rise in price not because of their real value, but because of hype and memes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2019_08_26_20_18_51_9e013a26c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SN>>(v1);
    }

    // decompiled from Move bytecode v6
}

