module 0x7468da86bdbf4c83f6adb6cf8e1fcad6a187934d8fd20ef6417eaee3604da7d4::spacecat {
    struct SPACECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACECAT>(arg0, 6, b"SPACECAT", b"FELICETTE", b"On October 18, 1963 French Scientists launched a rocket into space, containing a cat named Feilcette. She orbited 100 miles above earth, then came back down safely. Now she's ready to launch into outer space again, this time on SUI. Let's send this legendary cat to the moon where she belongs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/felicettespace_fac9765447.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

