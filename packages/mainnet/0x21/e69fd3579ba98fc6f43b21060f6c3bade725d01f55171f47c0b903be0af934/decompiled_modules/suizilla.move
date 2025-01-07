module 0x21e69fd3579ba98fc6f43b21060f6c3bade725d01f55171f47c0b903be0af934::suizilla {
    struct SUIZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZILLA>(arg0, 9, b"SUIZILLA", b"Sui Zilla", b"Sui zilla On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848887771743891456/RK7shKf1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIZILLA>(&mut v2, 466900000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZILLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

