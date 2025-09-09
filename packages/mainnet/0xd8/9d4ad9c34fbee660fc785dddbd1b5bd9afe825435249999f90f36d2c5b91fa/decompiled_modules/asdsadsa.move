module 0xd89d4ad9c34fbee660fc785dddbd1b5bd9afe825435249999f90f36d2c5b91fa::asdsadsa {
    struct ASDSADSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDSADSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDSADSA>(arg0, 9, b"asdsadsa", b"asdsadsads", b"dsadsadsadsad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ASDSADSA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDSADSA>>(v2, @0x3e8f93a16c31a79d450ba96c9ae494a8940b718125ad00b1361d35954c1e1670);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASDSADSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

