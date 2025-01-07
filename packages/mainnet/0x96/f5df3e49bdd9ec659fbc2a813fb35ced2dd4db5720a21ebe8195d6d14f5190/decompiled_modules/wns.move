module 0x96f5df3e49bdd9ec659fbc2a813fb35ced2dd4db5720a21ebe8195d6d14f5190::wns {
    struct WNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNS>(arg0, 9, b"WNS", b"Wolf Nun Sword", b"Sui enthusiasts are embracing Wolf Nun Sword, moving away from the frog meme trend.  https://www.wolfnunsword.fun/  https://x.com/wolfnunsword  https://t.me/WolfNunSword", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729690861872-fc2a239883841b0b2ab84c71f8c2a707.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WNS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

