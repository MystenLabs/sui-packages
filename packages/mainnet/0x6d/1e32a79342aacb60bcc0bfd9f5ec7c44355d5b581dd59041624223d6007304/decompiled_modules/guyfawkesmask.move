module 0x6d1e32a79342aacb60bcc0bfd9f5ec7c44355d5b581dd59041624223d6007304::guyfawkesmask {
    struct GUYFAWKESMASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUYFAWKESMASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUYFAWKESMASK>(arg0, 9, b"Anon", b"Guy Fawkes mask", b"The Guy Fawkes mask is one of the most enduring and powerful meme symbols to emerge from 4chan, particularly its infamous /b/ board. Though the mask originally gained fame through the 2005 film V for Vendetta, where it represented rebellion against authoritarian rule, it was 4chan that transformed it into a global icon of digital resistance and also used by one the most biggest hacking groups Anonymous $ANON | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiddl72ybmlqm4jiysq3ygwf4hpznkcikgkkpaioc7zrdoukfnqpji")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GUYFAWKESMASK>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUYFAWKESMASK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUYFAWKESMASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

