module 0x6e8661e456c3e467a8c35e97a8b2ef6cea41554422924840b15ea6aeb45572d7::iitoken {
    struct IITOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IITOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IITOKEN>(arg0, 9, b"iiTOKEN", b"OOTOKEN", b"what an II TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IITOKEN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IITOKEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IITOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

