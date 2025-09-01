module 0x99b99030075bcc314f30e05ff3c3ef6895555d69dd02610b6c92f20527c9281b::wifi {
    struct WIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFI>(arg0, 6, b"WIFI", b"WIFI", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WIFI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

