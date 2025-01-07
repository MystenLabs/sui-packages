module 0x93fcc8a4a3c8a81e6737001eb9a594ac073d90db220af71dc04546a158cca82b::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 9, b"SCAT", b"SCAT", b"SUI is the first SCAT in the blockchain world. We lead the trend and we lead the memecoin world of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844774701559934977/Lt1GiNyI_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

