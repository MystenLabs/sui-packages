module 0x6686401bcec911101924019776163f33ae8687920dd578f15de18aa3fed26924::mattbrett {
    struct MATTBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATTBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATTBRETT>(arg0, 6, b"MATTBRETT", b"Matt Brett", b"Welcome to the world MATT BRETT, an innovative meme coin leveraging blockchain technology on the sui chain network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727588694386_336d354b6d.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATTBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATTBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

