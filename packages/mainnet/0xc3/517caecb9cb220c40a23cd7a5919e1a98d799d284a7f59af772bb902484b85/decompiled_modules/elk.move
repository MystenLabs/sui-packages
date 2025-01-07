module 0xc3517caecb9cb220c40a23cd7a5919e1a98d799d284a7f59af772bb902484b85::elk {
    struct ELK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELK>(arg0, 6, b"Elk", b"Elonkn", b"Elonk Coin: The fun and playful, Add some fun to your crypto portfolio with this meme-inspired cryptocurrency featuring a famous pup.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000319428_6aec09c701.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELK>>(v1);
    }

    // decompiled from Move bytecode v6
}

