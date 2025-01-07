module 0x9b2d7e799695ad2426f132d0feedb0ffcfa0898703759ea0c0a4452e58180bb7::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 9, b"DOGGO", b"Doggo", b"Retarded version of $DOGE . This is just a meme SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1837532585775583233/gtPMPbe-_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

