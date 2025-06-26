module 0x171fc4e6924a7985f4f32e066ef3bf7087043fb61e568d5b312e56594b21cf21::idiot {
    struct IDIOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDIOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDIOT>(arg0, 6, b"IDIOT", b"idiot address 0xbe47b7fae8c33bcc186622d42e93b7c17102087f2bb0e506d54e5b84b53c2029", b"fuck you idiot spam deployed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifpprm2ckfug7wnkrm7sgsrn4faq4xipb7k4uf6okskk77zkzzv5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDIOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IDIOT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

