module 0x415897fe481898d1b3e91d8911fed1bc8f585f876b9a924b3fd436d0bf1bfdff::rostik {
    struct ROSTIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSTIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSTIK>(arg0, 9, b"ROSTIKSON", b"ROSTIKSON 2.0", b"We are all to blame for what happened.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gh4elw3WwAApPYx?format=png&name=240x240")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSTIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROSTIK>>(0x2::coin::mint<ROSTIK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ROSTIK>>(v2);
    }

    // decompiled from Move bytecode v6
}

