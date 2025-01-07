module 0x7ba17372f4dc04fce939f1c577ae68fb4b21c34eea4178fa66ca34458bd5942::sbcb {
    struct SBCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBCB>(arg0, 9, b"SBCB", b"sBatCraB", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://image.noelshack.com/fichiers/2023/50/5/1702607695-20231207-153633-0000.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBCB>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBCB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

