module 0x4722c051b8865298e695cbf9df4cdafe7d9d5cfce756174b2aa45d5d22512bc6::pupuiworld {
    struct PUPUIWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUIWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUIWORLD>(arg0, 6, b"PUPUIWORLD", b"PUPUI WORLD", x"505550554920574f524c4420204578706c6f72652c204372656174652c204f776e2e0a0a5374657020696e746f20505550554920574f524c442c20612076696272616e74203344206f70656e2d776f726c642067616d65206275696c74206f6e207468652053554920626c6f636b636861696e2c20776865726520616476656e74757265206d656574732074727565206469676974616c206f776e6572736869702e20456e746572206120766173742c20646563656e7472616c697a656420756e6976657273652066756c6c206f6620717569726b79206372656174757265732c2064796e616d6963206c616e647363617065732c20616e64206c696d69746c65737320706f73736962696c69746965732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihv3e4u2dqeubamm2yq6gpcq6thvtm66vifa4uzra2fk3lgxzejwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUIWORLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPUIWORLD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

