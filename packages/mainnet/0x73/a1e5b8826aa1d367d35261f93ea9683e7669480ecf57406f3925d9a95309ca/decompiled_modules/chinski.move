module 0x73a1e5b8826aa1d367d35261f93ea9683e7669480ecf57406f3925d9a95309ca::chinski {
    struct CHINSKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINSKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINSKI>(arg0, 9, b"CHINSKI", b"CHINESE SKI MASK DOG", b"CHINESE SKI MASK DOG meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x7f3d487b4f411b06ee8e71f6383c44c6518da8d3.png?size=lg&key=f2eb2e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHINSKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINSKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINSKI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

