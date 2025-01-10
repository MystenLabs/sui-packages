module 0x303b3196dba9a8ff78a194eda7cac1b8d8ce6fa83858b6ff91255b005b65fc38::pippin {
    struct PIPPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPIN>(arg0, 6, b"pippin", b"pippin", b"Pippin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTsYhZfbpzEgYV17F1EcwslVVxJfWSdFkDkQ&s"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPPIN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIPPIN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPIN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

