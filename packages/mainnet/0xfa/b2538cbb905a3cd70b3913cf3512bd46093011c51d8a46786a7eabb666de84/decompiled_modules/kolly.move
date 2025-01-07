module 0xfab2538cbb905a3cd70b3913cf3512bd46093011c51d8a46786a7eabb666de84::kolly {
    struct KOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLLY>(arg0, 9, b"Kolly", b"Kolly", b"KollyKolly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOLLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

