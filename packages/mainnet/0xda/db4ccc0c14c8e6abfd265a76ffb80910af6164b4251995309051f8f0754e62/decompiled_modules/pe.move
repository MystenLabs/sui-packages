module 0xdadb4ccc0c14c8e6abfd265a76ffb80910af6164b4251995309051f8f0754e62::pe {
    struct PE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PE>(arg0, 6, b"PE", b"Half of Pepe", b"Did you know that $PE - Half of $PEPE means half the market cap of the whole Pepe?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pepe_2b0b01aab7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PE>>(v1);
    }

    // decompiled from Move bytecode v6
}

