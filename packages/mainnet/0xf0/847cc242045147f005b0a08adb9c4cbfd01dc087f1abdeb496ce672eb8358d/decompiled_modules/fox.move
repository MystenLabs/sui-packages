module 0xf0847cc242045147f005b0a08adb9c4cbfd01dc087f1abdeb496ce672eb8358d::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"FoxSwap", x"466f7853776170e698afe59fbae4ba8e535549e58cbae59d97e993bee79a84e58ebbe4b8ade5bf83e58c96e887aae58aa8e5819ae5b882e59586e5b9b3e58fb0efbc8ce588a9e794a828414d4d29e7b3bbe7bb9fe69da5e7a1aee5ae9ae4bbb7e6a0bce38082e697a8e59ca8e69e84e5bbba0a535549e58cbae59d97e993bee4b88ae69c80e5bcbae98082e5ba94e680a7e79a84e6b581e58aa8e680a7e5bc95e6938ee38082", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755206385975.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

