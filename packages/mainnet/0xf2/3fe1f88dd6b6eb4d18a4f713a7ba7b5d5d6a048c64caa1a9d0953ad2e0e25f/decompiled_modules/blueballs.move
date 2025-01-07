module 0xf23fe1f88dd6b6eb4d18a4f713a7ba7b5d5d6a048c64caa1a9d0953ad2e0e25f::blueballs {
    struct BLUEBALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBALLS>(arg0, 6, b"BlueBalls", b"My SUIeet Blue Balls", b"Cats, dogs, squirrels.  Alright.  I like it.  But, I'm ready for these beautiful blue balls to shoot off to the moon!!!  Let's fucking goooooooo!  Again.  And again.  And again!!!  These SUIeet blue balls are always ready to gooooooo!!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734359777578.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEBALLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBALLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

