module 0x8364102823d6c3cec6b6c2431664b8aa8fd98fafab55efbc6993676d1276b877::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"Sam", b"Sam", b"Sam. Chiken's egg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAM>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

