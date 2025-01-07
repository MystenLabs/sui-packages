module 0xc178380e5086a003fe3df61db97db2bb90192f4070985e94deda4faa079412b2::kari {
    struct KARI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KARI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KARI>>(0x2::coin::mint<KARI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: KARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARI>(arg0, 9, b"KARI", b"KARI", b"$KARI is hot as you can guess...totally made fan meme for hottest chick ever conquering the sui world and community driven hot meme.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1618190989319081984/RwpLjOIG_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KARI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KARI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

