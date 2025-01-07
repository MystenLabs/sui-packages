module 0xebd76962aa6ba67b068524bb26591dda78cd70b6ac8457a81b2318a12b3e2020::tako {
    struct TAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKO>(arg0, 6, b"TAKO", b"Takotonimeme", x"53617920486f6c6120746f205461636f20546f6e692020536f6c616e6173206661766f7269746520666173742d666f6f64207461636f210a0a546f6e697320636f6f6c2e2048652064616e6365732c20686520706c6179732c206865206472696e6b7320626565722c2068652073696e677320616e64206b6e6f777320686f7720746f20706172747921200a0a466f6c6c6f7720546f6e69206f6e20736f6369616c206d6564696120746f2073656520776861742068657320757020746f20746f64617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038866_922c302d32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

