module 0xd9fe676722bbf30af880dd875b48bb21e95c49631ffde4bc6d1601a820257f32::meeseeks {
    struct MEESEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEESEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEESEEKS>(arg0, 9, b"meeseeks", b"Mr Meeseeks", b"Mr Meeseeks meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafkreibb3tkwctpqn42upfa6dberobwydwjv5sav6zeutkrvxgzze44emu.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MEESEEKS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEESEEKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEESEEKS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

