module 0x9c2c429ab523f0f40e62bd367275429f8ad9e244fb148226495ada0014bd01ab::prh {
    struct PRH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRH>(arg0, 9, b"PRH", b"PiranHype", b"nspired by the fierce and fun-loving piranha fish, PiranHype combines the thrill of the underwater world with the electrifying energy of the crypto community. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d1bbcfdebb59fd8ec783d596a135a4ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

