module 0x893a65387e55ee345106c55506ed8161ddd84b0c2c29b8de7c993ea35ed841be::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 9, b"SGOAT", b"Sui Goatsuis Maximus", b"Goatsuis Maximus will fulfill the prophecies of the ancient memeers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmapAq9WtNrtyaDtjZPAHHNYmpSZAQU6HywwvfSWq4dQVV?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SGOAT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

