module 0x95084f1c26d8e6a76ac78e20f41eeea3261dff6068eb194b509dda231a91feb7::dav {
    struct DAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAV>(arg0, 9, b"DAV", b"Darth Vader", b"Darth Vader is a fictional character in the Star Wars franchise. The character is the central antagonist of the original trilogy and, as Anakin Skywalker, is one of the main protagonists in the prequel trilogy. Star Wars creator George Lucas has collectively referred to the first six episodic films of the franchise as \"the tragedy of Darth Vader\". Darth Vader has become one of the most iconic villains in popular culture, and has been listed among the greatest villains and fictional characters ever. His masked face and helmet, in particular, is considered one of the most iconic character designs of all time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b59197537c7c3a716cdc62b6eda5d9a5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

