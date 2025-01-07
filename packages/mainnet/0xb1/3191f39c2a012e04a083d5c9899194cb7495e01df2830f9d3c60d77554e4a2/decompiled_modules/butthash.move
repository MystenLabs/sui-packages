module 0xb13191f39c2a012e04a083d5c9899194cb7495e01df2830f9d3c60d77554e4a2::butthash {
    struct BUTTHASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTHASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTHASH>(arg0, 6, b"BUTTHASH", b"JENKEM", b"AY AY WASSUP BOOOOY WE GOT DA STRAIGHT BUTTHASH RIGHT HERE, DAT OG JENKEM, WE GONNA GET HIGH AF UP IN HERE, WE BE FINNA DO SOME REAL SHIT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DAJENK_78141bdfe1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTHASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTHASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

