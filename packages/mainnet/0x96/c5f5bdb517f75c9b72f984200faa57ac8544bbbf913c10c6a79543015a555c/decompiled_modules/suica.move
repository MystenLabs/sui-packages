module 0x96c5f5bdb517f75c9b72f984200faa57ac8544bbbf913c10c6a79543015a555c::suica {
    struct SUICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICA>(arg0, 6, b"SUICA", b"Suica", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-21Cmh90y83tV-GCFT-Z-fNbqEHZMiVXnrQ&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUICA>>(v2);
    }

    // decompiled from Move bytecode v6
}

