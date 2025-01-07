module 0x8223b5b995b9b320a916af38add545e9254e5600ed0966cfe203e610b8db94eb::dadbod {
    struct DADBOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADBOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADBOD>(arg0, 6, b"DADBOD", b"Sui DadBod", b"DADBOD is a meme token on the sui network for mature crypto traders and a bit of fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012239_0b690ba598.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADBOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADBOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

