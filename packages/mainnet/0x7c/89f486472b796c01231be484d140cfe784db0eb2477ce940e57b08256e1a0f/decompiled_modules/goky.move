module 0x7c89f486472b796c01231be484d140cfe784db0eb2477ce940e57b08256e1a0f::goky {
    struct GOKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKY>(arg0, 9, b"GOKY", b"GOKKY", b"The new mascot of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1505731014609547264/zkzrW6rC.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOKY>(&mut v2, 280000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

