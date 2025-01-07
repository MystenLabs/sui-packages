module 0xfd4d7b14196756212918ee3d23ced93d2000df0956280944cbd014bf87c95962::crt {
    struct CRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRT>(arg0, 6, b"CRT", b"Carrot", b"Being a good memecoin full of laughter and fun is what CRT goals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009700_d505ad0a13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

