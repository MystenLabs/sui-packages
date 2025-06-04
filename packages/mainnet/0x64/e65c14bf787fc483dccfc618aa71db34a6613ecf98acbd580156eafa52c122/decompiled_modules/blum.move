module 0x64e65c14bf787fc483dccfc618aa71db34a6613ecf98acbd580156eafa52c122::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 6, b"Blum", b"BLUM", b"Blum provides access to all the coins and tokens you needall in one place. No more jumping between platforms. Simple and seamless! Memepad. Trading Terminal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000123736_1e6de03485.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

