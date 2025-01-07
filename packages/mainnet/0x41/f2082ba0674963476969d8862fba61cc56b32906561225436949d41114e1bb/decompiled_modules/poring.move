module 0x41f2082ba0674963476969d8862fba61cc56b32906561225436949d41114e1bb::poring {
    struct PORING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PORING>(arg0, 6, b"Poring", b"Poring", b"$PORING - The true meme token on $SUI blockchain with fair distribution on the http://hop.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/QmYj8AmP49qayhdAxRS7qkDP837SfGDvXcAB8ydm36yBfr")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PORING>>(0x2::coin::mint<PORING>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PORING>>(v2);
    }

    // decompiled from Move bytecode v6
}

