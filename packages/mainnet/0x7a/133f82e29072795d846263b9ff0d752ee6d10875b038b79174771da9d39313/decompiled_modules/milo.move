module 0x7a133f82e29072795d846263b9ff0d752ee6d10875b038b79174771da9d39313::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 9, b"MILO", b"MILO", b"MILO is a memecoin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://e7.pngegg.com/pngimages/95/643/png-clipart-puppy-illustration-dog-breed-poodle-cartoon-puppy-dog-breed.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

