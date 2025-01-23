module 0x45c09d6c1904592949ccb057d49f60a326aae2eff247b1f24480ff392c59da10::allfather {
    struct ALLFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLFATHER>(arg0, 9, b"ALLFATHER", b"Let's test this shit", b"Why is meme trading on Sui dead? Where is all the aggregator volume coming from", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e74e77cbe1a8cff812de07601b5cd2c4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLFATHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLFATHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

