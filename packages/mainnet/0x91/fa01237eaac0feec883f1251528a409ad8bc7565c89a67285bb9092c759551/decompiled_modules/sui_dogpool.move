module 0x91fa01237eaac0feec883f1251528a409ad8bc7565c89a67285bb9092c759551::sui_dogpool {
    struct SUI_DOGPOOL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_DOGPOOL>, arg1: 0x2::coin::Coin<SUI_DOGPOOL>) {
        0x2::coin::burn<SUI_DOGPOOL>(arg0, arg1);
    }

    fun init(arg0: SUI_DOGPOOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DOGPOOL>(arg0, 9, b"DOGPOOL", b"SUI DogPool", b"The SUI top meme dog is here! The badass hero/villain that combines crypto and memes together! https://t.me/+PHtAqt18ueo4NDc0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1839075561508892672/QxWo-trT_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_DOGPOOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DOGPOOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_DOGPOOL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_DOGPOOL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

