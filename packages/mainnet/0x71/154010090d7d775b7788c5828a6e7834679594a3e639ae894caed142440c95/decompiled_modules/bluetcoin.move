module 0x71154010090d7d775b7788c5828a6e7834679594a3e639ae894caed142440c95::bluetcoin {
    struct BLUETCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUETCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUETCOIN>(arg0, 9, b"BLUETCOIN", b"BlueMove Bitcoin", b"The only bitcoin on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://as2.ftcdn.net/v2/jpg/02/42/78/61/1000_F_242786194_WgAtfn7aMF5MeDv7YkdoAljKhhv7G5Rd.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUETCOIN>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUETCOIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUETCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

