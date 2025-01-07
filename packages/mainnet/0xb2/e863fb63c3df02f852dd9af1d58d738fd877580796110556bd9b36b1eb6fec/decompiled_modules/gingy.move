module 0xb2e863fb63c3df02f852dd9af1d58d738fd877580796110556bd9b36b1eb6fec::gingy {
    struct GINGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GINGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GINGY>(arg0, 9, b"GINGY", b"The Gingerbread Man", b"Welcome to $GINGY, celebrating the festive magic of the gingerbread man! Inspired by Gingy from Shrek and the timeless holiday icon, our token brings laughter, warmth, and a sprinkle of mischief to the season. Join us in keeping the charm of the gingerbread man alive this Christmas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreidhnju43hehr2qsbax7exvm55pjs2kfovueiwm3xfp6wlhr7qjhwy.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GINGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GINGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GINGY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

