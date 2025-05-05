module 0xa837507509278e5d95b655be139631c14a6ccf98a35d9d0dae7695a477308188::sch {
    struct SCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCH>(arg0, 6, b"SCH", b"HELPMEGOTOSCHOOL", x"492077616e7420746f20726169736520656e6f756768206d6f6e6579200a536f207468617420492063616e20676f20746f207363686f6f6c20746869732079656172", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegtqbpzhkhxshsloo7hoejr7eoo24khkaj2pe3p4qmdtvzvp4o5q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

