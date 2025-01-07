module 0xb5b603827d1bfb2859200fd332d5e139ccac2598f0625de153a87cf78954e0c4::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 9, b"WEWE", b"WEWE", b"WEWE is a cutest fat-ass cat. Built by the Wave Trading community, WEWE will always be by your side on your meme adventures", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/logos/wewe.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
        0x2::coin::mint_and_transfer<WEWE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

