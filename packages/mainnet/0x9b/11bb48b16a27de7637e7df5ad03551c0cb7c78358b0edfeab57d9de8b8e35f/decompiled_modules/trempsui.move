module 0x9b11bb48b16a27de7637e7df5ad03551c0cb7c78358b0edfeab57d9de8b8e35f::trempsui {
    struct TREMPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMPSUI>(arg0, 9, b"TREMPSUI", b"SUI TREMP", b"Memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000478165_8b5eaed826.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TREMPSUI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMPSUI>>(v2, @0x7b9c8730a6f8e6f0b74f4a26a09c986fa326103048130271cb58a045be81acf2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

