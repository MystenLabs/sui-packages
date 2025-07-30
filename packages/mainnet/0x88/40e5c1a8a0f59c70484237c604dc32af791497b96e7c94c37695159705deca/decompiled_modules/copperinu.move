module 0x8840e5c1a8a0f59c70484237c604dc32af791497b96e7c94c37695159705deca::copperinu {
    struct COPPERINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPPERINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPPERINU>(arg0, 9, b"COPPER", b"Copper Inu", b"Copper is the dog behind the original BONK meme. | Website: https://knowyourmeme.com/memes/bonk-cheems | Twitter: https://x.com/mike8pump/status/1947801033562067333 | Created on: https://bonk.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemkna7asuafdxdi4smtq3zzt3ex6s2d25em42slabemlvvvizoky")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COPPERINU>(&mut v2, 1000000000000000000, @0xfa3e6c5e61bf55f576b6500503c1a4d8f64756c44acc510e42e86ad1d1bcc406, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPPERINU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPPERINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

