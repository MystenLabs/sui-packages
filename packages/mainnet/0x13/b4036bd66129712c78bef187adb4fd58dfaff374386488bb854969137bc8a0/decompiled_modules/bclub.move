module 0x13b4036bd66129712c78bef187adb4fd58dfaff374386488bb854969137bc8a0::bclub {
    struct BCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCLUB>(arg0, 9, b"BCLUB", b"BoysClub", b"BoysClub (BCLUB) is a meme-inspired token that celebrates the origins of Pepe the Frog, rooted in Matt Furie's Boy's Club comic series. Embracing the playful spirit of meme culture, BoysClub fosters a fun, community-driven atmosphere with a focus on humor and engagement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1831718661666570240/eWgIzz7e.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BCLUB>(&mut v2, 2800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCLUB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

