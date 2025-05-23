module 0x3ab83f7995cb3e301f19370aa97336a32364df83e41ef3d32a679806f7e8ff44::spacecat {
    struct SPACECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACECAT>(arg0, 6, b"SPACECAT", b"FELICETTE", b"On October 18, 1963 French Scientists launched a rocket into space, containing a cat named Feilcette. She orbited 100 miles above earth, then came back down safely. Now she's ready to launch into outer space again, this time on SUI. Let's send this legendary cat to the moon where she belongs!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_4911556748544945760_y_2c5c98f294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPACECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

